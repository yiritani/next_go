package cmd

import (
	"context"
	"fmt"
	proto "grpc_backend/src/_generated/proto/v1"
	"log"

	"connectrpc.com/connect"
)

type PingServer struct{}

func (p *PingServer) Ping(
	ctx context.Context,
	req *connect.Request[proto.PingRequest],
) (*connect.Response[proto.PingResponse], error) {
	log.Println("Ping")
	if req == nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("request cannot be nil"))
	}
	if req.Msg == nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("PingRequest cannot be nil"))
	}
	res := connect.NewResponse(&proto.PingResponse{
		Message: "Pong from gRPC backend",
	})
	res.Header().Set("Content-Type", "application/json")
	return res, nil
}
