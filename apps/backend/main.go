package main

import (
	"context"
	"fmt"
	"github.com/jackc/pgx/v5/pgxpool"
	"os"
	"tutorial.sqlc.dev/app/src/api"
)

func main() {
	postgresUser := os.Getenv("POSTGRES_USER")
	postgresPassword := os.Getenv("POSTGRES_PASSWORD")
	postgresHost := os.Getenv("POSTGRES_HOST")
	postgresPort := os.Getenv("POSTGRES_PORT")
	postgresDb := os.Getenv("POSTGRES_DB")
	connString := fmt.Sprintf("postgresql://%s:%s@%s:%s/%s?sslmode=disable", postgresUser, postgresPassword, postgresHost, postgresPort, postgresDb)

	var err error
	pool, err := pgxpool.New(context.Background(), connString)
	if err != nil {
		panic(err)
		os.Exit(1)
	}
	defer pool.Close()
	api.NewServer(pool).Run()
}
