package sqlc

import (
	"context"
	"github.com/jackc/pgx/v5/pgtype"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_SelectSystem(t *testing.T) {
	insertedSystem := insertTestSystem(t)
	selectedSystem, err := testQueries.SelectSystem(context.Background(), insertedSystem.ID)
	require.NoError(t, err)
	require.Equal(t, insertedSystem.ID, selectedSystem.ID)
	require.Equal(t, insertedSystem.SystemName, selectedSystem.SystemName)
}

func TestQueries_ListSystems(t *testing.T) {
	systems, err := testQueries.ListSystems(context.Background(), ListSystemsParams{
		Limit:  10,
		Offset: 0,
	})
	require.NoError(t, err)
	require.NotEmpty(t, systems)
}

func TestQueries_SelectSystemUsers(t *testing.T) {
	system := insertTestSystem(t)
	user := insertTestUser(t)
	systemUserRelation, err := testQueries.InsertSystemUserRelation(context.Background(), InsertSystemUserRelationParams{
		SystemID:   system.ID,
		UserID:     user.ID,
		SystemRole: SystemRolePmoOwner,
	})
	require.NoError(t, err)

	systemUsers, err := testQueries.SelectSystemUsers(context.Background(), system.ID)
	require.NoError(t, err)
	require.NotEmpty(t, systemUsers)
	require.Equal(t, systemUserRelation.UserID, systemUsers[0].UserID)
	require.Equal(t, systemUserRelation.SystemRole, systemUsers[0].SystemRole)
}

func TestQueries_SelectSystemUsersUndefined(t *testing.T) {
	testUuid := pgtype.UUID{}
	systemUsers, err := testQueries.SelectSystemUsers(context.Background(), testUuid)
	require.NoError(t, err)
	require.Empty(t, systemUsers)
}
