package cmd

import (
	"context"
	"fmt"
	proto "grpc_backend/src/_generated/proto/v1"
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
	if req == nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("request cannot be nil"))
	}
	if req.Msg == nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, fmt.Errorf("ListUserRequest cannot be nil"))
	}
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
