// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: insert_user.sql

package sqlc

import (
	"context"
)

const insertUser = `-- name: InsertUser :one
INSERT INTO users (
    username, email
) VALUES (
             ?, ?
         )
    RETURNING user_id, username, email
`

type InsertUserParams struct {
	Username string
	Email    string
}

func (q *Queries) InsertUser(ctx context.Context, arg InsertUserParams) (User, error) {
	row := q.db.QueryRowContext(ctx, insertUser, arg.Username, arg.Email)
	var i User
	err := row.Scan(&i.UserID, &i.Username, &i.Email)
	return i, err
}
