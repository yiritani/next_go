package controller

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	"grpc_backend/src/_generated/proto"
	"grpc_backend/src/services"
	"grpc_backend/src/sqlc"
	"log"
	"time"
)

type OrderServer struct {
	Queries *sqlc.Queries
}

func (p *OrderServer) ListOrders(
	ctx context.Context,
	req *connect.Request[proto.ListOrdersRequest],
	stream *connect.ServerStream[proto.ListOrdersResponse]) error {
	log.Println("Called Order")

	userId := req.Msg.UserId
	fmt.Println("User ID: ", userId)

	orders, err := services.ServiceGetOrders(p.Queries, ctx, userId)
	if err != nil {
		log.Printf("Failed to get orders: %v", err)
		return err
	}

	for _, order := range orders {
		res := &proto.ListOrdersResponse{
			Order: &proto.Order{
				UserId:    order.UserId,
				OrderId:   order.OrderId,
				Username:  order.Username,
				ProductId: order.ProductId,
				Quantity:  order.Quantity,
				OrderDate: order.OrderDate,
			},
		}
		if err := stream.Send(res); err != nil {
			log.Printf("Failed to send response: %v", err)
			return err
		}
		time.Sleep(1 * time.Second)
	}

	return nil
}
