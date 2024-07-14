// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: account_transfer.sql

package sqlc

import (
	"context"
)

const getAccountTransfers = `-- name: GetAccountTransfers :many
SELECT
    accounts.id as account_id,
    accounts.owner as account_owner,
    accounts.balance as account_balance,
    accounts.currency as account_currency,
    transfers.id as transfer_id,
    transfers.from_account_id as transfer_from_account_id,
    transfers.to_account_id as transfer_to_account_id,
    transfers.amount as transfer_amount
FROM
    accounts
inner join transfers on accounts.id = transfers.from_account_id
where
    accounts.id = $1
`

type GetAccountTransfersRow struct {
	AccountID             int64
	AccountOwner          string
	AccountBalance        int64
	AccountCurrency       string
	TransferID            int64
	TransferFromAccountID int64
	TransferToAccountID   int64
	TransferAmount        int64
}

func (q *Queries) GetAccountTransfers(ctx context.Context, id int64) ([]GetAccountTransfersRow, error) {
	rows, err := q.db.Query(ctx, getAccountTransfers, id)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []GetAccountTransfersRow{}
	for rows.Next() {
		var i GetAccountTransfersRow
		if err := rows.Scan(
			&i.AccountID,
			&i.AccountOwner,
			&i.AccountBalance,
			&i.AccountCurrency,
			&i.TransferID,
			&i.TransferFromAccountID,
			&i.TransferToAccountID,
			&i.TransferAmount,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
