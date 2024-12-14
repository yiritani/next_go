package main

import (
	"context"
	"fmt"
	"github.com/jackc/pgx/v5/pgxpool"
	"os"
	"tutorial.sqlc.dev/app/src/api"
)

func main() {
	user := os.Getenv("POSTGRES_USER")
	password := os.Getenv("POSTGRES_PASSWORD")
	db := os.Getenv("POSTGRES_DB")
	host := os.Getenv("POSTGRES_HOST")
	port := os.Getenv("POSTGRES_PORT")

	connString := fmt.Sprintf("user=%s password=%s host=%s port=%s dbname=%s sslmode=disable", user, password, host, port, db)
	var err error
	pool, err := pgxpool.New(context.Background(), connString)
	if err != nil {
		panic(err)
		os.Exit(1)
	}
	defer pool.Close()
	api.NewServer(pool).Run()
}
