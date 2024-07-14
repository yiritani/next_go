// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: system_select.sql

package sqlc

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
)

const listSystems = `-- name: ListSystems :many
SELECT id, system_name, created_at from "system"
LIMIT $1
OFFSET $2
`

type ListSystemsParams struct {
	Limit  int64
	Offset int64
}

func (q *Queries) ListSystems(ctx context.Context, arg ListSystemsParams) ([]System, error) {
	rows, err := q.db.Query(ctx, listSystems, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []System{}
	for rows.Next() {
		var i System
		if err := rows.Scan(&i.ID, &i.SystemName, &i.CreatedAt); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const selectSystem = `-- name: SelectSystem :one
SELECT id, system_name, created_at from "system" WHERE "id" = $1
`

func (q *Queries) SelectSystem(ctx context.Context, id pgtype.UUID) (System, error) {
	row := q.db.QueryRow(ctx, selectSystem, id)
	var i System
	err := row.Scan(&i.ID, &i.SystemName, &i.CreatedAt)
	return i, err
}

const selectSystemUsers = `-- name: SelectSystemUsers :many
SELECT
"system".id as system_id,
"user".id as user_id,
"user".name as user_name,
"user".email as email
from "system"
INNER JOIN "systemUserRelation" ON "system"."id" = "systemUserRelation"."system_id"
INNER JOIN "user" ON "systemUserRelation"."user_id" = "user"."id"
WHERE "system"."id" = $1
`

type SelectSystemUsersRow struct {
	SystemID pgtype.UUID
	UserID   pgtype.UUID
	UserName string
	Email    string
}

func (q *Queries) SelectSystemUsers(ctx context.Context, id pgtype.UUID) ([]SelectSystemUsersRow, error) {
	rows, err := q.db.Query(ctx, selectSystemUsers, id)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []SelectSystemUsersRow{}
	for rows.Next() {
		var i SelectSystemUsersRow
		if err := rows.Scan(
			&i.SystemID,
			&i.UserID,
			&i.UserName,
			&i.Email,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
