package sqlc

import (
	"database/sql"
	"log"

	_ "modernc.org/sqlite"
)

func Connect(dataSourceName string) *sql.DB {
	db, err := sql.Open("sqlite", dataSourceName)
	if err != nil {
		log.Fatal(err)
	}
	return db
}
