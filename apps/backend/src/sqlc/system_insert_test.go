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
