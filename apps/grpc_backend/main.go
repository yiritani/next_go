package main

import (
	"grpc_backend/src/cmd"
	"grpc_backend/src/sqlc"
)

func main() {
	databasePath := "./db.sqlite"
	conn := sqlc.Connect(databasePath)

	defer conn.Close()

	queries := sqlc.New(conn)

	cmd.NewServer(queries)
}
