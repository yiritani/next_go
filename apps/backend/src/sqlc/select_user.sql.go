// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: select_user.sql

package sqlc

import (
	"context"
)

const getUserByID = `-- name: GetUserByID :one
SELECT user_id, username, email
FROM users
WHERE user_id = ?
`

func (q *Queries) GetUserByID(ctx context.Context, userID int64) (User, error) {
	row := q.db.QueryRowContext(ctx, getUserByID, userID)
	var i User
	err := row.Scan(&i.UserID, &i.Username, &i.Email)
	return i, err
}

const listUsers = `-- name: ListUsers :many
SELECT user_id, username, email
FROM users
ORDER BY user_id ASC
`

func (q *Queries) ListUsers(ctx context.Context) ([]User, error) {
	rows, err := q.db.QueryContext(ctx, listUsers)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []User{}
	for rows.Next() {
		var i User
		if err := rows.Scan(&i.UserID, &i.Username, &i.Email); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
