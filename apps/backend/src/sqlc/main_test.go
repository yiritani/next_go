package sqlc

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/exec"
	"testing"

	"github.com/jackc/pgx/v5"
)

const (
	dbSource = "postgresql://postgres:test_password@localhost:54321/postgres?sslmode=disable"
)

var testQueries *Queries

func runMigrations(connString string) error {
	cmd := exec.Command(
		"migrate",
		"-path", "../db/migration",
		"-database", fmt.Sprintf("\"%s\"", connString),
		"-verbose",
		"up")
	fmt.Print(cmd)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

func runMigrationsDown(connString string) error {
	cmd := exec.Command(
		"migrate",
		"-path", "../db/migration",
		"-database", fmt.Sprintf("\"%s\"", connString),
		" -verbose", "down")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

func TestMain(m *testing.M) {
	defer func(dbSource string) {
		err := runMigrationsDown(dbSource)
		if err != nil {

		}
	}(dbSource)

	//err := runMigrations(dbSource)
	//if err != nil {
	//	return
	//}

	ctx := context.Background()
	conn, err := pgx.Connect(ctx, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(conn)

	os.Exit(m.Run())
}
