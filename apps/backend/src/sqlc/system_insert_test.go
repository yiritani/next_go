package sqlc

import (
	"context"
	"github.com/stretchr/testify/require"
	"testing"
	"tutorial.sqlc.dev/app/src/lib"
)

func insertTestSystem(t *testing.T) System {
	ctx := context.Background()
	randSystemName := lib.CreateRandomString(10)
	system, err := testQueries.InsertSystem(ctx, randSystemName)
	if err != nil {
		t.Fatal(err)
	}
	require.NotEmpty(t, system)
	require.Equal(t, randSystemName, system.SystemName)
	require.NotZero(t, system.ID)
	require.NotZero(t, system.CreatedAt)
	return system
}

func TestQueries_InsertSystem(t *testing.T) {
	insertTestSystem(t)
}

func TestQueries_InsertSystemUserRelation(t *testing.T) {
	roleName := SystemRolePmoOwner
	system := insertTestSystem(t)
	user := insertTestUser(t)
	systemUserRelation, err := testQueries.InsertSystemUserRelation(context.Background(), InsertSystemUserRelationParams{
		SystemID:   system.ID,
		UserID:     user.ID,
		SystemRole: roleName,
	})
	require.NoError(t, err)
	require.NotEmpty(t, systemUserRelation)
	require.Equal(t, system.ID, systemUserRelation.SystemID)
	require.Equal(t, user.ID, systemUserRelation.UserID)
	require.Equal(t, roleName, systemUserRelation.SystemRole)
	require.NotZero(t, systemUserRelation.CreatedAt)
}
