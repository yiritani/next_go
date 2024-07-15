// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: system_delete.sql

package sqlc

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
)

const deleteSystemUserRelation = `-- name: DeleteSystemUserRelation :one
DELETE FROM "system_user_relation" WHERE system_id = $1 AND user_id = $2 RETURNING system_id, user_id, system_role, created_at
`

type DeleteSystemUserRelationParams struct {
	SystemID pgtype.UUID
	UserID   pgtype.UUID
}

func (q *Queries) DeleteSystemUserRelation(ctx context.Context, arg DeleteSystemUserRelationParams) (SystemUserRelation, error) {
	row := q.db.QueryRow(ctx, deleteSystemUserRelation, arg.SystemID, arg.UserID)
	var i SystemUserRelation
	err := row.Scan(
		&i.SystemID,
		&i.UserID,
		&i.SystemRole,
		&i.CreatedAt,
	)
	return i, err
}
