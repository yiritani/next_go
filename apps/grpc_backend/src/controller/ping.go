package controller

import (
	"connectrpc.com/connect"
	"context"
	"grpc_backend/src/_generated/proto"
	"log"
)

type PingServer struct{}

func (p *PingServer) Ping(
	ctx context.Context,
	req *connect.Request[proto.PingRequest],
) (*connect.Response[proto.PingResponse], error) {
	log.Println("Ping")
	res := connect.NewResponse(&proto.PingResponse{
		Message: "Pong",
	})
	res.Header().Set("Content-Type", "application/json")
	return res, nil
}
