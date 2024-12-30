package services

import (
	"context"
	"grpc_backend/src/pb"
	"grpc_backend/src/sqlc"
)

func ServiceGetOrders(queries *sqlc.Queries, ctx context.Context, userId int64) ([]*pb.Order, error) {
	orders, err := queries.GetOrderByUserID(ctx, userId)
	if err != nil {
		return nil, err
	}

	var orderResponses []*pb.Order
	for _, order := range orders {
		orderResponses = append(orderResponses, &pb.Order{
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
