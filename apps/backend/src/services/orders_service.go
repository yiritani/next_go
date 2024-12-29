package services

import (
	"context"
	"fmt"
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

func ServiceCreateOrder(queries sqlc.Queries, ctx context.Context, order sqlc.InsertOrderParams) (OrderResponse, error) {
	fmt.Println("ServiceCreateOrder")
	newOrder, err := queries.InsertOrder(ctx, sqlc.InsertOrderParams{
		UserID:    order.UserID,
		ProductID: order.ProductID,
		Quantity:  order.Quantity,
		OrderDate: order.OrderDate,
	})
	fmt.Println("newOrder", newOrder)
	if err != nil {
		return OrderResponse{}, err
	}

	return OrderResponse{
		OrderID:   newOrder.OrderID,
		UserID:    newOrder.UserID,
		ProductID: newOrder.ProductID,
		Quantity:  newOrder.Quantity,
		OrderDate: newOrder.OrderDate,
	}, nil
}
