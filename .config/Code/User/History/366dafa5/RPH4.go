package main

import (
	"bytes"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"log"
	"math/rand"
	"net/http"
	"os"
	"strconv"
	"strings"
	"sync"
	"sync/atomic"
	"time"
)

type request_payload struct {
	Key   string `json:"key"`
	Value string `json:"value"`
}

type ResponsePayload struct {
	Key    string `json:"key"`
	Value  string `json:"value"`
	Source string `json:"source"`
}

type Metrics struct {
	successfulRequests uint64
	failedRequests     uint64
	totalResponseTime  uint64 // in ms
	mutex              sync.Mutex
	responseTimes      []time.Duration
}

type WorkloadType string

const (
	WorkloadPutAll     WorkloadType = "put-all"
	WorkloadGetAll     WorkloadType = "get-all"
	WorkloadGetPopular WorkloadType = "get-popular"
	WorkloadMixed      WorkloadType = "mixed"
)

type LoadGenerator struct {
	serverURL          string
	numThreads         int
	durationSeconds    int
	workloadType       WorkloadType
	metrics            *Metrics
	httpClient         *http.Client
	stop_routines      chan struct{}
	wg                 sync.WaitGroup
	no_of_popular_keys int
	valueSize          int
}

func NewLoadGenerator(serverURL string, numThreads int, duration int, workload WorkloadType, popularKeys int, valueSize int) *LoadGenerator {
	return &LoadGenerator{
		serverURL:          serverURL,
		numThreads:         numThreads,
		durationSeconds:    duration,
		workloadType:       workload,
		metrics:            &Metrics{},
		httpClient:         &http.Client{},
		stop_routines:      make(chan struct{}),
		no_of_popular_keys: popularKeys,
		valueSize:          valueSize,
	}
}

func (lg *LoadGenerator) generateKey(threadID int, requestNum int) string {
	switch lg.workloadType {
	case WorkloadGetPopular:
		return fmt.Sprintf("%d", requestNum%lg.no_of_popular_keys)
	default:
		return fmt.Sprintf("%d_%d", threadID, requestNum)
	}
}

func (lg *LoadGenerator) generateValue(size int) string {
	const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:',.<>?/"
	b := make([]byte, size)
	for i := range b {
		b[i] = charset[rand.Intn(len(charset))]
	}
	return string(b)
}

func (lg *LoadGenerator) post_request(key, value string) (time.Duration, error) {
	payload := request_payload{
		Key:   key,
		Value: value,
	}

	jsonData, err := json.Marshal(payload)
	if err != nil {
		return 0, err
	}

	startTime := time.Now()
	resp, err := lg.httpClient.Post(
		fmt.Sprintf("%s/kv-post", lg.serverURL),
		"application/json",
		bytes.NewBuffer(jsonData),
	)
	duration := time.Since(startTime)

	if err != nil {
		return duration, err
	}
	defer resp.Body.Close()

	/*
		If i dont read all the respoonse body there is still unread data left in the TCP stream. So there is some data means Go's HTTP client cannot reuse that connection because the stream is "dirty" or incomplete.
		TODO: Why ? Doesnt go override the previous response body when new request is made on same connection ?
	*/
	io.Copy(io.Discard, resp.Body)

	if resp.StatusCode != 201 {
		return duration, fmt.Errorf("POST failed with status: %d", resp.StatusCode)
	}

	return duration, nil
}

func (lg *LoadGenerator) get_request(key string) (time.Duration, error) {
	startTime := time.Now()
	resp, err := lg.httpClient.Get(fmt.Sprintf("%s/kv-get/%s", lg.serverURL, key))
	duration := time.Since(startTime)

	if err != nil {
		return duration, err
	}
	defer resp.Body.Close()

	io.Copy(io.Discard, resp.Body)

	if resp.StatusCode != 200 {
		return duration, fmt.Errorf("GET failed with status: %d", resp.StatusCode)
	}

	return duration, nil
}

func (lg *LoadGenerator) delete_request(key string) (time.Duration, error) {
	req, err := http.NewRequest(http.MethodDelete, fmt.Sprintf("%s/kv-delete/%s", lg.serverURL, key), nil)
	if err != nil {
		return 0, err
	}

	startTime := time.Now()
	resp, err := lg.httpClient.Do(req)
	duration := time.Since(startTime)

	if err != nil {
		return duration, err
	}
	defer resp.Body.Close()

	io.Copy(io.Discard, resp.Body)

	if resp.StatusCode != 200 {
		return duration, fmt.Errorf("DELETE failed with status: %d", resp.StatusCode)
	}

	return duration, nil
}

func (lg *LoadGenerator) prefill_popular_keys() error {
	log.Printf("Pre-filling popular keys...")
	for i := 0; i < lg.no_of_popular_keys; i++ {
		key := lg.generateKey(0, i)
		value := lg.generateValue(lg.valueSize)
		lg.post_request(key, value)
	}
	log.Printf("Pre-filling of popular keys completed.")
	time.Sleep(1 * time.Second)
	log.Printf("Filling the cache...")
	for i := 0; i < lg.no_of_popular_keys; i++ {
		key := lg.generateKey(0, i)
		lg.get_request(key)
	}
	log.Printf("Cache pre-filled with popular keys.")
	return nil
}

func (lg *LoadGenerator) update_metrics(duration time.Duration, request_status bool) {
	// Update metrics based on request status
	if request_status {
		atomic.AddUint64(&lg.metrics.successfulRequests, 1)
		atomic.AddUint64(&lg.metrics.totalResponseTime, uint64(duration.Milliseconds()))
		lg.metrics.mutex.Lock()
		lg.metrics.responseTimes = append(lg.metrics.responseTimes, duration)
		lg.metrics.mutex.Unlock()
	} else {
		atomic.AddUint64(&lg.metrics.failedRequests, 1)
	}
}

func (lg *LoadGenerator) handle_client(threadID int) {
	defer lg.wg.Done()

	request_num := 0
	rnd := rand.New(rand.NewSource(time.Now().UnixNano() + int64(threadID)))

	keys_for_mixed := make([]string, 0)

	for {
		select {
		case <-lg.stop_routines:
			return
		default:
			var duration time.Duration
			var err error

			key := lg.generateKey(threadID, request_num)
			value := lg.generateValue(lg.valueSize)

			switch lg.workloadType {
			case WorkloadPutAll:
				// IO load : Inserting multiple key-value pairs into db
				duration, err = lg.post_request(key, value)
			case WorkloadGetAll:
				// IO bound: Multiple reads from db
				// Adding some kv pairs to db first
				cache_size, _ := strconv.Atoi(os.Getenv("CACHE_SIZE"))
				for i := 0; i < cache_size; i++ {
					_, err := lg.post_request(lg.generateKey(threadID, i), lg.generateValue(lg.valueSize))
					if err != nil {
						log.Printf("Error pre-filling cache: %v", err)
					}
				}
				time.Sleep(1 * time.Second)
				duration, err = lg.get_request(key)
			case WorkloadGetPopular:
				// CPU/Memory bound: Cache hits
				// First I need to fill the cache with popular keys (Dont forget to check the cache size in server)
				// Now before starting to send get requests, i need to fill the cache
				// In my current implementation.  I will pre-fill the popular keys before starting the load test
				duration, err = lg.get_request(key)
			case WorkloadMixed:
				operation := rnd.Intn(100)
				if operation < 60 {
					if len(keys_for_mixed) > 0 {
						key = keys_for_mixed[rnd.Intn(len(keys_for_mixed))]
					}
					duration, err = lg.get_request(key)
				} else if operation < 85 {
					duration, err = lg.post_request(key, value)
					keys_for_mixed = append(keys_for_mixed, key)
				} else {
					if len(keys_for_mixed) > 0 {
						key = keys_for_mixed[rnd.Intn(len(keys_for_mixed))]
					}
					duration, err = lg.delete_request(key)
					if err != nil {
						for i, k := range keys_for_mixed {
							if k == key {
								keys_for_mixed = append(keys_for_mixed[:i], keys_for_mixed[i+1:]...)
								break
							}
						}
					}
				}
			}

			lg.update_metrics(duration, err == nil)

			if err != nil {
				log.Printf("Thread %d: Error at request %d: %v", threadID, request_num, err)
			}

			request_num++
		}
	}
}

func (lg *LoadGenerator) Start() {
	log.Printf("Starting load Testing...")
	log.Printf("Server URL: %s", lg.serverURL)
	log.Printf("Threads: %d", lg.numThreads)
	log.Printf("Duration: %d seconds", lg.durationSeconds)
	log.Printf("Workload: %s", lg.workloadType)
	log.Printf("Value Size: %d bytes", lg.valueSize)
	if lg.workloadType == WorkloadGetPopular {
		log.Printf("No of Popular Keys: %d", lg.no_of_popular_keys)
		prefill_error := lg.prefill_popular_keys()
		if prefill_error != nil {
			log.Printf("Error pre-filling popular keys: %v", prefill_error)
		}
		time.Sleep(2 * time.Second)
		log.Printf("Starting load test after pre-filling popular keys...")
	}

	startTime := time.Now()

	for i := 0; i < lg.numThreads; i++ {
		lg.wg.Add(1)
		go lg.handle_client(i) // goroutine - nice concept
	}

	time.Sleep(time.Duration(lg.durationSeconds) * time.Second)

	/* TODO: Way to stop threads */
	close(lg.stop_routines)
	lg.wg.Wait()

	actual_duration := time.Since(startTime).Seconds()
	lg.print_results(actual_duration)
}

func (lg *LoadGenerator) print_results(duration float64) {
	successfulReqs := atomic.LoadUint64(&lg.metrics.successfulRequests)
	failedReqs := atomic.LoadUint64(&lg.metrics.failedRequests)
	totalResponseTime := atomic.LoadUint64(&lg.metrics.totalResponseTime)

	average_throughput := float64(successfulReqs) / duration
	avgResponseTime := float64(0)
	if successfulReqs > 0 {
		avgResponseTime = float64(totalResponseTime) / float64(successfulReqs)
	}

	fmt.Println("\n" + strings.Repeat("=", 60))
	fmt.Println("LOAD TEST RESULTS")
	fmt.Println(strings.Repeat("=", 60))
	fmt.Printf("Workload Type:           %s\n", lg.workloadType)
	fmt.Printf("Number of Threads:       %d\n", lg.numThreads)
	fmt.Printf("Test Duration:           %.2f seconds\n", duration)
	fmt.Printf("Value Size:              %d bytes\n", lg.valueSize)
	fmt.Println(strings.Repeat("-", 60))
	fmt.Printf("Successful Requests:     %d\n", successfulReqs)
	fmt.Printf("Failed Requests:         %d\n", failedReqs)
	fmt.Printf("Total Requests:          %d\n", successfulReqs+failedReqs)
	fmt.Println(strings.Repeat("-", 60))
	fmt.Printf("Average Throughput:      %.2f requests/second\n", average_throughput)
	fmt.Printf("Average Response Time:   %.2f ms\n", avgResponseTime)

	fmt.Println(strings.Repeat("=", 60))

	switch lg.workloadType {
	case WorkloadPutAll:
		file, err := os.OpenFile("put_all.txt", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
		if err != nil {
			log.Printf("Error opening put_all.txt: %v", err)
			return
		}
		defer file.Close()

		entry := fmt.Sprintf("%d,%d,%.2f,%.2f\n", lg.numThreads, lg.durationSeconds, average_throughput, avgResponseTime)
		if _, err := file.WriteString(entry); err != nil {
			log.Printf("Error writing to put_all.txt: %v", err)
		}
	case WorkloadGetAll:
		file, err := os.OpenFile("get_all.txt", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
		if err != nil {
			log.Printf("Error opening get_all.txt: %v", err)
			return
		}
		defer file.Close()

		entry := fmt.Sprintf("%d,%d,%.2f,%.2f\n", lg.numThreads, lg.durationSeconds, average_throughput, avgResponseTime)
		if _, err := file.WriteString(entry); err != nil {
			log.Printf("Error writing to get_all.txt: %v", err)
		}
	case WorkloadGetPopular:
		file, err := os.OpenFile("popular_keys.txt", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
		if err != nil {
			log.Printf("Error opening popular_keys.txt: %v", err)
			return
		}
		defer file.Close()

		entry := fmt.Sprintf("%d,%d,%d,%.2f,%.2f\n", lg.numThreads, lg.durationSeconds, lg.no_of_popular_keys, average_throughput, avgResponseTime)
		if _, err := file.WriteString(entry); err != nil {
			log.Printf("Error writing to popular_keys.txt: %v", err)
		}
	case WorkloadMixed:
		file, err := os.OpenFile("mixed.txt", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
		if err != nil {
			log.Printf("Error opening mixed.txt: %v", err)
			return
		}
		defer file.Close()

		entry := fmt.Sprintf("%d,%d,%.2f,%.2f\n", lg.numThreads, lg.durationSeconds, average_throughput, avgResponseTime)
		if _, err := file.WriteString(entry); err != nil {
			log.Printf("Error writing to mixed.txt: %v", err)
		}
	}
}

func main() {
	// Command line flags
	serverURL := flag.String("url", "http://localhost:8080", "Server URL")
	numThreads := flag.Int("threads", 10, "Number of concurrent client threads")
	duration := flag.Int("duration", 60, "Test duration in seconds (default: 300 = 5 minutes)")
	workload := flag.String("workload", "get-popular", "Workload type: put-all, get-all, get-popular, mixed")
	popularKeys := flag.Int("popular-keys", 100, "Number of popular keys for get-popular workload")
	valueSize := flag.Int("value-size", 1024, "Size of values in bytes")

	flag.Parse()

	validWorkloads := map[string]WorkloadType{
		"put-all":     WorkloadPutAll,
		"get-all":     WorkloadGetAll,
		"get-popular": WorkloadGetPopular,
		"mixed":       WorkloadMixed,
	}

	workloadType, ok := validWorkloads[*workload]
	if !ok {
		log.Fatalf("Invalid workload type: %s. Valid options: put-all, get-all, get-popular, mixed", *workload)
	}

	lg := NewLoadGenerator(*serverURL, *numThreads, *duration, workloadType, *popularKeys, *valueSize)
	lg.Start()
}

func init() {
	rand.Seed(time.Now().UnixNano())
}
