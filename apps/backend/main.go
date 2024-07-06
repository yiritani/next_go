package main

import (
	"context"
	"github.com/jackc/pgx/v5/pgxpool"
	"os"
	"tutorial.sqlc.dev/app/src/api"
)

func main() {
	connString := "user=postgres password=password host=localhost port=5432 dbname=postgres sslmode=disable"
	var err error
	pool, err := pgxpool.New(context.Background(), connString)
	if err != nil {
		panic(err)
		os.Exit(1)
	}
	defer pool.Close()
	api.NewServer(pool).Run()
}
