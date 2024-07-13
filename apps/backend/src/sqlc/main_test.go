package sqlc

import (
	"context"
	"log"
	"os"
	"testing"

	"github.com/jackc/pgx/v5"
)

const (
	dbDriver = "postgres"
	dbSource = "postgresql://postgres:password@localhost:5432/postgres?sslmode=disable"
)

var testQueries *Queries

func TestMain(m *testing.M) {
	ctx := context.Background()
	conn, err := pgx.Connect(ctx, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(conn)

	os.Exit(m.Run())
}
