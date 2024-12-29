// TODO: なぜかrootに置かないとroutesが読まれない
package main

import (
	"tutorial.sqlc.dev/app/src/api"
	"tutorial.sqlc.dev/app/src/sqlc"
)

func main() {
	databasePath := "./db.sqlite"

	conn := sqlc.Connect(databasePath)
	defer conn.Close()

	queries := sqlc.New(conn)
	server := api.NewServer(queries)

	server.Routes()
	server.Run(":8080")
}
