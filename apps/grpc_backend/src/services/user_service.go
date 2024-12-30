package services

import (
	"context"
	"grpc_backend/src/pb"
	"grpc_backend/src/sqlc"
)

func ServiceGetAllUsers(queries *sqlc.Queries, ctx context.Context) ([]*pb.User, error) {
	users, err := queries.ListUsers(ctx)
	if err != nil {
		return nil, err
	}

	var userResponses []*pb.User
	for _, user := range users {
		userResponses = append(userResponses, &pb.User{
			UserId:   user.UserID,
			Username: user.Username,
			Email:    user.Email,
		})
	}

	return userResponses, nil
}
