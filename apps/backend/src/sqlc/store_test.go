package sqlc

import (
	"context"
	"log"
	"testing"

	"github.com/jackc/pgx/v5"
	"github.com/stretchr/testify/require"
)


func TextAccountTx(t *testing.T) {
	ctx := context.Background()
	conn, err := pgx.Connect(ctx, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(conn)
	err = accountTx(ctx, conn, testQueries)
	if err != nil {
		t.Fatal(err)
	}
}

func TestTransferTxMultipleAccounts(t *testing.T) {
	ctx := context.Background()
	account1 := createTestAccount(t)
	account2 := createTestAccount(t)
	account3 := createTestAccount(t)

	n := 5
	amount := int64(10)

	errs := make(chan error)
	results := make(chan TransferTxResult)


	for i := 0; i < n; i++ {
		conn, err := pgx.Connect(ctx, dbSource)
		if err != nil {
			log.Fatal("cannot connect to db:", err)
		}

		go func() {
			result, err := TransferTx(ctx, conn, testQueries, TransferTxParamas{
				FromAccountID: account1.ID,
				ToAccountID:   account2.ID,
				Amount:        amount,
			})

			errs <- err
			results <- result
		}()
	}

	for i := 0; i < n; i++ {
		conn, err := pgx.Connect(ctx, dbSource)
		if err != nil {
			log.Fatal("cannot connect to db:", err)
		}
		go func() {
			result, err := TransferTx(ctx, conn, testQueries, TransferTxParamas{
				FromAccountID: account2.ID,
				ToAccountID:   account3.ID,
				Amount:        amount,
			})

			errs <- err
			results <- result
		}()
	}

	for i := 0; i < n*2; i++ {
		err := <-errs
		require.NoError(t, err)

		result := <-results
		t.Log(result)
		transfer := result.Transfer
		require.NotEmpty(t, transfer)
		require.Equal(t, amount, transfer.Amount)
		require.NotZero(t, transfer.ID)
		require.NotZero(t, transfer.CreatedAt)

		fromEntry := result.FromEntry
		require.NotEmpty(t, fromEntry)
		require.Equal(t, -amount, fromEntry.Amount)
		require.NotZero(t, fromEntry.ID)
		require.NotZero(t, fromEntry.CreatedAt)

		toEntry := result.ToEntry
		require.NotEmpty(t, toEntry)
		require.Equal(t, amount, toEntry.Amount)
		require.NotZero(t, toEntry.ID)
		require.NotZero(t, toEntry.CreatedAt)
	}
}
