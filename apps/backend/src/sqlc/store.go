package sqlc

import (
	"context"
	"github.com/jackc/pgx/v5"
)

type AccountTxResult struct {
	Account Account
}

type TransferTxParams struct {
	FromAccountID int64 `json:"from_account_id"`
	ToAccountID   int64 `json:"to_account_id"`
	Amount        int64 `json:"amount"`
}

type TransferTxResult struct {
	Transfer    Transfer
	FromEntry   Entry
	ToEntry     Entry
	FromAccount Account
	ToAccount   Account
}

func TransferTx(ctx context.Context, db *pgx.Conn, queries *Queries, args TransferTxParams) (TransferTxResult, error) {
	tx, err := db.Begin(ctx)
	if err != nil {
		return (TransferTxResult{}), err
	}

	var result TransferTxResult

	defer tx.Rollback(ctx)

	qtx := queries.WithTx(tx)
	transfer, err := qtx.CreateTransfer(ctx, CreateTransferParams(args))
	if err != nil {
		return (TransferTxResult{}), err
	}

	fromEntry, err := qtx.CreateEntry(ctx, CreateEntryParams{
		AccountID: args.FromAccountID,
		Amount:    -args.Amount,
	})
	if err != nil {
		return (TransferTxResult{}), err
	}

	toEntry, err := qtx.CreateEntry(ctx, CreateEntryParams{
		AccountID: args.ToAccountID,
		Amount:    args.Amount,
	})
	if err != nil {
		return (TransferTxResult{}), err
	}

	account1, err := qtx.GetAccountForUpdate(ctx, args.FromAccountID)
	if err != nil {
		return (TransferTxResult{}), err
	}
	fromAccount, err := qtx.UpdateAccount(ctx, UpdateAccountParams{
		ID:      account1.ID,
		Balance: account1.Balance - args.Amount,
	})
	if err != nil {
		return (TransferTxResult{}), err
	}

	account2, err := qtx.GetAccountForUpdate(ctx, args.ToAccountID)
	if err != nil {
		return (TransferTxResult{}), err
	}
	toAccount, err := qtx.UpdateAccount(ctx, UpdateAccountParams{
		ID:      account2.ID,
		Balance: account2.Balance + args.Amount,
	})
	if err != nil {
		return (TransferTxResult{}), err
	}

	tx.Commit(ctx)

	result.Transfer = transfer
	result.FromEntry = fromEntry
	result.ToEntry = toEntry
	result.FromAccount = fromAccount
	result.ToAccount = toAccount

	return result, nil
}
