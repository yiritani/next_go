package controller

import (
	"fmt"
	pb "grpc_backend/src/pb"
	"grpc_backend/src/services"
	"grpc_backend/src/sqlc"
	"log"
	"time"
)

type OrdersServer struct {
	pb.UnimplementedOrdersServiceServer
	Queries *sqlc.Queries
}

func (s *OrdersServer) ListOrders(req *pb.ListOrdersRequest, stream pb.OrdersService_ListOrdersServer) error {
	fmt.Println("ListOrders called")
	ctx := stream.Context()

	userId := req.GetUserId()
	orders, err := services.ServiceGetOrders(s.Queries, ctx, userId)
	if err != nil {
		log.Printf("Error fetching orders: %v", err)
	}

	for _, order := range orders {
		response := &pb.ListOrdersResponse{
			Order: order,
		}
		if err := stream.Send(response); err != nil {
			log.Printf("Failed to send order: %v", err)
			return err
		}
		fmt.Printf("Sent order: %+v\n", order)
		time.Sleep(1 * time.Second)
	}

	return nil
}
