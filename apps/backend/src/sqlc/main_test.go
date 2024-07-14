package sqlc

import (
	"context"
	"fmt"
	"log"
	"os"
	"testing"

	"github.com/jackc/pgx/v5"
)

var testQueries *Queries

func TestMain(m *testing.M) {
	// ローカルで実施しないとgoの機能のソース上どこテストしたかしてないかを表示できないので、それを環境変数でどうすれば良いのか不明
	//postgresUser := os.Getenv("TEST_POSTGRES_USER")
	//postgresPassword := os.Getenv("TEST_POSTGRES_PASSWORD")
	//postgresHost := os.Getenv("TEST_POSTGRES_HOST")
	//postgresPort := os.Getenv("TEST_POSTGRES_PORT")
	//postgresDb := os.Getenv("TEST_POSTGRES_DB")
	postgresUser := "postgres"
	postgresPassword := "test_password"
	postgresHost := "localhost"
	postgresPort := "54321"
	postgresDb := "postgres"
	connString := fmt.Sprintf("postgresql://%s:%s@%s:%s/%s?sslmode=disable", postgresUser, postgresPassword, postgresHost, postgresPort, postgresDb)

	ctx := context.Background()
	conn, err := pgx.Connect(ctx, connString)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(conn)

	os.Exit(m.Run())
}
