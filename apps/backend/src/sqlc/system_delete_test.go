package sqlc

import (
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_DeleteSystemUserRelation(t *testing.T) {
	roleName := SystemRolePmoOwner
	system := insertTestSystem(t)
	user := insertTestUser(t)
	_, err := testQueries.InsertSystemUserRelation(context.Background(), InsertSystemUserRelationParams{
		SystemID:   system.ID,
		UserID:     user.ID,
		SystemRole: roleName,
	})
	require.NoError(t, err)

	deletedSystemUserRelation, err := testQueries.DeleteSystemUserRelation(context.Background(), DeleteSystemUserRelationParams{
		SystemID: system.ID,
		UserID:   user.ID,
	})

	require.NoError(t, err)
	require.Equal(t, system.ID, deletedSystemUserRelation.SystemID)
	require.Equal(t, user.ID, deletedSystemUserRelation.UserID)
}
