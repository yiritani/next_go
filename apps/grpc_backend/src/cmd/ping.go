package cmd

import (
	"connectrpc.com/connect"
	"context"
	proto "grpc_backend/src/_generated/proto/v1"
	"log"
)

type PingServer struct{}

func (p *PingServer) Ping(
	ctx context.Context,
	req *connect.Request[proto.PingRequest],
) (*connect.Response[proto.PingResponse], error) {
	log.Println("Ping")
	res := connect.NewResponse(&proto.PingResponse{
		Message: "Pong from gRPC backend",
	})
	res.Header().Set("Content-Type", "application/json")
	return res, nil
}
