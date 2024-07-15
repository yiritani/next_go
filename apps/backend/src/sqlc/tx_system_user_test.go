package sqlc

import (
	"context"
	"github.com/jackc/pgx/v5"
	"github.com/stretchr/testify/require"
	"log"
	"testing"
	"tutorial.sqlc.dev/app/src/lib"
)

func TestQueries_TxInsertSystemUserRelation(t *testing.T) {
	insertedSystem := insertTestSystem(t)
	name := lib.CreateRandomString(5)
	userArg := User{
		Email: name + "@test.com",
		Name:  name,
	}

	txSystemUserRequest := TxSystemUserRequest{
		SystemID:   insertedSystem.ID,
		User:       userArg,
		SystemRole: "pmo_owner",
	}

	conn, err := pgx.Connect(context.Background(), connString)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	tx, err := conn.Begin(context.Background())

	err = testQueries.TxInsertSystemUserRelation(context.Background(), tx, txSystemUserRequest)

	require.NoError(t, err)
}
