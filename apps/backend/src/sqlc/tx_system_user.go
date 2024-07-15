package sqlc

import (
	"context"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgtype"
)

type TxSystemUserRequest struct {
	SystemID   pgtype.UUID
	User       User
	SystemRole SystemRole
}

// TxInsertSystemUserRelation 実際こんな関数要らないけど例のためだけに作成
func (q *Queries) TxInsertSystemUserRelation(ctx context.Context, tx pgx.Tx, args TxSystemUserRequest) error {
	defer tx.Rollback(ctx)
	qtx := q.WithTx(tx)

	insertedUser, err := qtx.InsertUser(ctx, InsertUserParams{
		Email: args.User.Email,
		Name:  args.User.Name,
	})
	if err != nil {
		return err
	}

	_, err = qtx.InsertSystemUserRelation(ctx, InsertSystemUserRelationParams{
		SystemID:   args.SystemID,
		UserID:     insertedUser.ID,
		SystemRole: args.SystemRole,
	})
	if err != nil {
		return err
	}

	tx.Commit(ctx)

	return nil
}
