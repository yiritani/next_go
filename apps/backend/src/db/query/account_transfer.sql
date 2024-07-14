-- name: GetAccountTransfers :many
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
    accounts.id = $1;
