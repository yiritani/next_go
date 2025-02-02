// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.28.0
// source: select_orders.sql

package sqlc

import (
	"context"
)

const getOrderByUserID = `-- name: GetOrderByUserID :many
SELECT users.user_id, users.username, order_id, product_id , quantity, order_date
FROM orders
INNER JOIN users ON orders.user_id = users.user_id
WHERE orders.user_id = ?
`

type GetOrderByUserIDRow struct {
	UserID    int64
	Username  string
	OrderID   int64
	ProductID int64
	Quantity  int64
	OrderDate string
}

func (q *Queries) GetOrderByUserID(ctx context.Context, userID int64) ([]GetOrderByUserIDRow, error) {
	rows, err := q.db.QueryContext(ctx, getOrderByUserID, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []GetOrderByUserIDRow{}
	for rows.Next() {
		var i GetOrderByUserIDRow
		if err := rows.Scan(
			&i.UserID,
			&i.Username,
			&i.OrderID,
			&i.ProductID,
			&i.Quantity,
			&i.OrderDate,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
