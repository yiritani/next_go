package controller

import (
	"context"
	"fmt"
	pb "grpc_backend/src/pb"
)

type PingServer struct {
	pb.UnimplementedPingServiceServer
}

func (s *PingServer) Ping(ctx context.Context, req *pb.PingRequest) (*pb.PingResponse, error) {
	fmt.Println("Ping called")
	return &pb.PingResponse{
		Message: "Pong from gRPC server",
	}, nil
}
