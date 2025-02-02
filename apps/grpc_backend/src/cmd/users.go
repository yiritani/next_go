package cmd

import (
	"context"
	"grpc_backend/src/_generated/proto"
	"grpc_backend/src/services"
	"grpc_backend/src/sqlc"
	"log"

	"connectrpc.com/connect"
)

type UserServer struct {
	Queries *sqlc.Queries
}

func (p *UserServer) ListUsers(
	ctx context.Context,
	req *connect.Request[proto.ListUserRequest],
) (*connect.Response[proto.ListUserResponse], error) {
	log.Println("Called Users")
	users, err := services.ServiceGetAllUsers(p.Queries, ctx)
	if err != nil {
		return nil, err
	}

	res := connect.NewResponse(&proto.ListUserResponse{
		Users: users,
	})
	res.Header().Set("Content-Type", "application/json")
	return res, nil
}
