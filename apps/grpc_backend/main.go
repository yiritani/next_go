package main

import (
	"grpc_backend/src/controller"
	"grpc_backend/src/sqlc"
)

func main() {
	databasePath := "./db.sqlite"
	conn := sqlc.Connect(databasePath)

	defer conn.Close()

	queries := sqlc.New(conn)

	controller.NewServer(queries)
}
