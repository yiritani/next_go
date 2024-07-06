// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: system.sql

package sqlc

import (
	"context"
)

const createSystem = `-- name: CreateSystem :one
INSERT INTO "system" (system_name) VALUES ($1) RETURNING id, system_name, created_at
`

func (q *Queries) CreateSystem(ctx context.Context, systemName string) (System, error) {
	row := q.db.QueryRow(ctx, createSystem, systemName)
	var i System
	err := row.Scan(&i.ID, &i.SystemName, &i.CreatedAt)
	return i, err
}
