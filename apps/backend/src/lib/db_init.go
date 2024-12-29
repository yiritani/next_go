package lib

import (
	"database/sql"
	"log"
	"os"
)

func DbInit(db *sql.DB) {
	if err := runMigration(db, "./src/db/migration/000001_init_schema.up.sql"); err != nil {
		log.Fatalf("migration error: %v", err)
	}
	if err := runMigration(db, "./src/db/migration/002_fixture.sql"); err != nil {
		log.Fatalf("fixture load error: %v", err)
	}
}

func runMigration(db *sql.DB, filePath string) error {
	content, err := os.ReadFile(filePath)
	if err != nil {
		return err
	}
	_, err = db.Exec(string(content))
	return err
}
