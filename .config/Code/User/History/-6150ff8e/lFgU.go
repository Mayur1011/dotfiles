package main

import (
	"container/list"
	"log"
	"sync"
)

type Cache struct {
	max_size  int
	items     map[string]*list.Element // items['key'] = pointer to list element
	evictList *list.List
	mutex     sync.RWMutex
	hits      uint64
	misses    uint64
}

type CacheItem struct {
	key   string
	value string
}

func Cache_Create(cache_size int) *Cache {
	return &Cache{
		max_size:  cache_size,
		items:     make(map[string]*list.Element),
		evictList: list.New(),
	}
}

func (c *Cache) Cache_Print() {
	if c.evictList.Len() == 0 {
		println("Cache is empty...")
		return
	}

	println("Cache data:")
	for e := c.evictList.Front(); e != nil; e = e.Next() {
		item := e.Value.(*CacheItem)
		println("Key:", item.key, "Value:", item.value)
	}
}

func (c *Cache) Cache_Get(key string) (bool, string) {
	c.mutex.RLock()
	defer c.mutex.RUnlock()

	element, found := c.items[key]
	if found {
		log.Printf("cache.go : Cache hit for key: %s", key)
		c.hits++
		c.evictList.MoveToFront(element)
		return true, element.Value.(*CacheItem).value
	}
	c.misses++
	log.Printf("cache.go : Total misses so far: %d", c.misses)
	log.Printf("cache.go : Total hits so far: %d", c.hits)
	return false, ""
}

func (c *Cache) Cache_Insert(key string, value string) {
	c.mutex.Lock()
	defer c.mutex.Unlock()

	log.Printf("cache.go : Inserting key: %s, value length: %d into cache", key, len(value))

	element, found := c.items[key]
	if found {
		c.evictList.MoveToFront(element)
		element.Value.(*CacheItem).value = value
		return
	}

	if c.evictList.Len() >= c.max_size {
		last_element := c.evictList.Back()
		if last_element != nil {
			key_to_remove := last_element.Value.(*CacheItem).key
			delete(c.items, key_to_remove)

			c.evictList.Remove(last_element)
		}
	}

	cache_item := &CacheItem{key: key, value: value}
	element = c.evictList.PushFront(cache_item)
	c.items[key] = element

	// c.Cache_Print()
}

func (c *Cache) Cache_Delete(key string) {
	c.mutex.Lock()
	defer c.mutex.Unlock()

	element, found := c.items[key]
	if found {
		delete(c.items, key)
		c.evictList.Remove(element)
		log.Printf("cache.go : Deleted key: %s from cache", key)
	} else {
		log.Printf("cache.go : No such key found in cache")
	}

	// c.Cache_Print()
}
