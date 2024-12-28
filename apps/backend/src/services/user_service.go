package services

import (
	"context"
	"tutorial.sqlc.dev/app/src/sqlc"
)

func ServiceGetAllUsers(queries sqlc.Queries, ctx context.Context) ([]sqlc.User, error) {
	users, err := queries.ListUsers(ctx)
	if err != nil {
		return nil, err
	}
	return users, nil
}
