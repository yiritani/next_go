package controller

import (
	"context"
	pb "grpc_backend/src/pb"
	"grpc_backend/src/services"
	"grpc_backend/src/sqlc"
	"log"
)

type UsersServer struct {
	pb.UnimplementedUsersServiceServer
	Queries *sqlc.Queries
}

func (s *UsersServer) ListUsers(ctx context.Context, req *pb.ListUsersRequest) (*pb.ListUsersResponse, error) {
	users, err := services.ServiceGetAllUsers(s.Queries, ctx)
	if err != nil {
		log.Printf("Error fetching users: %v", err)
		return nil, err
	}

	return &pb.ListUsersResponse{
		Users: users,
	}, nil
}
