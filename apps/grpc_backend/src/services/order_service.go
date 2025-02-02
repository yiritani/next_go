package services

import (
	"context"
	"fmt"
	proto "grpc_backend/src/_generated/proto/v1"
	"grpc_backend/src/sqlc"
)

func ServiceGetOrders(queries *sqlc.Queries, ctx context.Context, userId int64) ([]*proto.Order, error) {
	orders, err := queries.GetOrderByUserID(ctx, userId)
	if err != nil {
		return nil, err
	}

	var orderResponses []*proto.Order
	for _, order := range orders {
		orderResponses = append(orderResponses, &proto.Order{
			UserId:    order.UserID,
			OrderId:   order.OrderID,
			Username:  order.Username,
			ProductId: order.ProductID,
			Quantity:  order.Quantity,
			OrderDate: order.OrderDate,
		})
	}

	return orderResponses, nil
}

func ServiceCreateOrder(queries sqlc.Queries, ctx context.Context, order sqlc.InsertOrderParams) (*proto.Order, error) {
	fmt.Println("ServiceCreateOrder")
	newOrder, err := queries.InsertOrder(ctx, sqlc.InsertOrderParams{
		UserID:    order.UserID,
		ProductID: order.ProductID,
		Quantity:  order.Quantity,
		OrderDate: order.OrderDate,
	})
	fmt.Println("newOrder", newOrder)
	if err != nil {
		return nil, err
	}

	return &proto.Order{
		UserId:    newOrder.UserID,
		OrderId:   newOrder.OrderID,
		ProductId: newOrder.ProductID,
		Quantity:  newOrder.Quantity,
		OrderDate: newOrder.OrderDate,
	}, nil
}
