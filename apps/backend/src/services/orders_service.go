package services

import (
	"context"
	"tutorial.sqlc.dev/app/src/sqlc"
)

type OrderResponse struct {
	OrderID   int64  `json:"order_id"`
	UserID    int64  `json:"user_id"`
	Username  string `json:"username"`
	ProductID int64  `json:"product_id"`
	Quantity  int64  `json:"quantity"`
	OrderDate string `json:"order_date"`
}

func ServiceGetOrdersByUserId(queries sqlc.Queries, ctx context.Context, userId int64) ([]OrderResponse, error) {
	orders, err := queries.GetOrderByUserID(ctx, userId)
	if err != nil {
		return nil, err
	}

	var orderResponses []OrderResponse
	for _, order := range orders {
		orderResponses = append(orderResponses, OrderResponse{
			UserID:    order.UserID,
			Username:  order.Username,
			OrderID:   order.OrderID,
			ProductID: order.ProductID,
			Quantity:  order.Quantity,
			OrderDate: order.OrderDate,
		})
	}

	return orderResponses, nil
}
