package services

import (
	"context"
	"tutorial.sqlc.dev/app/src/sqlc"
)

func ServiceGetOrdersByUserId(queries sqlc.Queries, ctx context.Context, userId int64) ([]sqlc.GetOrderByUserIDRow, error) {
	orders, err := queries.GetOrderByUserID(ctx, userId)
	if err != nil {
		return nil, err
	}
	return orders, nil
}
