package services

import (
	"context"
	"fmt"
	"tutorial.sqlc.dev/app/src/sqlc"
)

func ServiceGetAllUsers(queries sqlc.Queries, ctx context.Context) ([]sqlc.User, error) {
	fmt.Println("services.ServiceGetAllUsers")
	users, err := queries.ListUsers(ctx)
	if err != nil {
		return nil, err
	}
	fmt.Println("Users: ", users)
	return users, nil
}
