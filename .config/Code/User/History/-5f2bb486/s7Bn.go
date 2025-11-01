// package main

// import (
// 	"database/sql"
// 	"fmt"
// 	"log"

// 	// _ "github.com/lib/pq"
// 	_ "github.com/go-sql-driver/mysql"
// )

// func DB_connect(host string, port int, user string, password string, dbname string) (*sql.DB, error) {
// 	// psql_info := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)
// 	dsn := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?parseTime=true&charset=utf8mb4&loc=Local", user, password, host, port, dbname)

// 	var err error
// 	// db, err := sql.Open("postgres", psql_info)
// 	db, err := sql.Open("mysql", dsn)
// 	if err != nil {
// 		return nil, fmt.Errorf("error opening database: %v", err)
// 	}
// 	err = db.Ping()
// 	if err != nil {
// 		return nil, fmt.Errorf("error connecting to the database: %v", err)
// 	}
// 	return db, nil
// }

// func DB_create_table(db *sql.DB) error {
// 	create_table_query := `
// 	CREATE TABLE IF NOT EXISTS kvstore (
// 		key VARCHAR(256) PRIMARY KEY,
// 		value TEXT NOT NULL
// 	);`
// 	_, err := db.Exec(create_table_query)
// 	if err != nil {
// 		return fmt.Errorf("error creating table: %v", err)
// 	}
// 	log.Println("db.go : Table 'kvstore' created or already exists")

// 	truncate_table_query := `TRUNCATE TABLE kvstore;`
// 	_, err = db.Exec(truncate_table_query)
// 	if err != nil {
// 		return fmt.Errorf("error truncating table: %v", err)
// 	}
// 	log.Println("db.go : Table 'kvstore' truncated")
// 	return nil
// }

// func DB_insert(db *sql.DB, key string, value string) error {
// 	log.Printf("db.go : Inserting key: %s with value length: %d", key, len(value))

// 	insert_query := `
// 	INSERT INTO kvstore (key, value)
// 	VALUES ($1, $2)
// 	ON CONFLICT (key)
// 	DO UPDATE SET value = EXCLUDED.value;`

// 	_, err := db.Exec(insert_query, key, value)
// 	if err != nil {
// 		log.Printf("db.go : Error inserting key-value pair: %v", err)
// 		return fmt.Errorf("error inserting key-value pair: %v", err)
// 	}
// 	return nil
// }

// // func DB_insert(db *sql.DB, key string, value string) error {
// // 	log.Printf("db.go : Inserting key: %s with value length: %d", key, len(value))
// //
// // 	_, err := db.Exec("SET LOCAL synchronous_commit = on;")
// // 	if err != nil {
// // 		return fmt.Errorf("failed to set synchronous_commit: %v", err)
// // 	}
// //
// // 	_, err = db.Exec("BEGIN;")
// // 	if err != nil {
// // 		return fmt.Errorf("db.go : Failed to begin transaction: %v", err)
// // 	}
// //
// // 	insertQuery := `
// // 		INSERT INTO kvstore (key, value)
// // 		VALUES ($1, $2)
// // 		ON CONFLICT (key)
// // 		DO UPDATE SET value = EXCLUDED.value;`
// //
// // 	_, err = db.Exec(insertQuery, key, value)
// // 	if err != nil {
// // 		db.Exec("ROLLBACK;")
// // 		return fmt.Errorf("error inserting key-value pair: %v", err)
// // 	}
// //
// // 	_, err = db.Exec("COMMIT;")
// // 	if err != nil {
// // 		db.Exec("ROLLBACK;")
// // 		return fmt.Errorf("commit failed: %v", err)
// // 	}
// //
// // 	return nil
// // }

// func DB_get(db *sql.DB, key string) (string, error) {
// 	log.Printf("db.go : Retrieving value for key: %s", key)
// 	get_query := `SELECT value FROM kvstore WHERE key = $1;`

// 	var value string
// 	err := db.QueryRow(get_query, key).Scan(&value)

// 	if err != nil {
// 		if err == sql.ErrNoRows {
// 			return "", fmt.Errorf("key not found")
// 		}
// 		return "", fmt.Errorf("error retrieving value: %v", err)
// 	}
// 	return value, nil
// }

// func DB_delete(db *sql.DB, key string) error {
// 	log.Printf("db.go : Deleting key: %s", key)
// 	delete_query := `DELETE FROM kvstore WHERE key = $1;`

// 	_, err := db.Exec(delete_query, key)
// 	if err != nil {
// 		return fmt.Errorf("error deleting key-value pair: %v", err)
// 	}

// 	// Delete from cache

// 	return nil
// }
