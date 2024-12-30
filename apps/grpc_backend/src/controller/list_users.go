package controller

import (
	"context"
	"fmt"
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
	fmt.Println("ListUsers called")
	users, err := services.ServiceGetAllUsers(s.Queries, ctx)
	if err != nil {
		log.Printf("Error fetching users: %v", err)
		return nil, err
	}

	fmt.Println("Users fetched", users)
	return &pb.ListUsersResponse{
		Users: users,
	}, nil
}