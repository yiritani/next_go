package services

import (
	"context"
	"grpc_backend/src/_generated/proto"
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
