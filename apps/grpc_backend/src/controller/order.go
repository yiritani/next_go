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

// ListOrders TODO: ちょっとよく分からないが、
// 関数はpublicにしないとコンスタラクタが作れないのと、多分.protoファイルの関数名と一致させた方が管理が楽
// あと、多分connect.Request内の型でどのprotoのserviceと紐づくか決めているっぽい。
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

func (p *OrderServer) CreateOrder(
	ctx context.Context,
	req *connect.Request[proto.CreateOrderRequest]) (*connect.Response[proto.CreateOrderResponse], error) {
	log.Println("Called Create Order")

	var order sqlc.InsertOrderParams
	order.UserID = req.Msg.UserId
	order.ProductID = req.Msg.ProductId
	order.Quantity = req.Msg.Quantity
	order.OrderDate = time.Now().Format("2006-01-02")

	newOrder, err := services.ServiceCreateOrder(*p.Queries, ctx, order)
	if err != nil {
		log.Printf("Failed to create order: %v", err)
		return nil, err
	}

	res := connect.NewResponse(&proto.CreateOrderResponse{
		Order: &proto.Order{
			UserId:    newOrder.UserId,
			OrderId:   newOrder.OrderId,
			ProductId: newOrder.ProductId,
			Quantity:  newOrder.Quantity,
			OrderDate: newOrder.OrderDate,
		},
	})
	res.Header().Set("Content-Type", "application/json")
	return res, nil
}
