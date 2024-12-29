package services

import (
	"context"
	"tutorial.sqlc.dev/app/src/sqlc"
)

type UserResponse struct {
	UserID   int64  `json:"user_id"`
	Username string `json:"username"`
	Email    string `json:"email"`
}

func ServiceGetAllUsers(queries sqlc.Queries, ctx context.Context) ([]UserResponse, error) {
	users, err := queries.ListUsers(ctx)
	if err != nil {
		return nil, err
	}

	var userResponses []UserResponse
	for _, user := range users {
		userResponses = append(userResponses, UserResponse{
			UserID:   user.UserID,
			Username: user.Username,
			Email:    user.Email,
		})
	}

	return userResponses, nil
}
