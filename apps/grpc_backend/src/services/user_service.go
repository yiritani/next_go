package services

import (
	"context"
	"grpc_backend/src/_generated/proto"
	"grpc_backend/src/sqlc"
)

func ServiceGetAllUsers(queries *sqlc.Queries, ctx context.Context) ([]*proto.User, error) {
	users, err := queries.ListUsers(ctx)
	if err != nil {
		return nil, err
	}

	var userResponses []*proto.User
	for _, user := range users {
		userResponses = append(userResponses, &proto.User{
			UserId:   user.UserID,
			Username: user.Username,
			Email:    user.Email,
		})
	}

	return userResponses, nil
}
