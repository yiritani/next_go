package sqlc

import (
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_DeleteUser(t *testing.T) {
	insertedUser := insertTestUser(t)
	deletedUser, err := testQueries.DeleteUser(context.Background(), insertedUser.ID)

	require.NoError(t, err)
	require.NotEmpty(t, deletedUser)
	require.Equal(t, insertedUser.ID, deletedUser.ID)

	selectedUser, err := testQueries.SelectUser(context.Background(), insertedUser.ID)
	require.Error(t, err)
	require.Empty(t, selectedUser)
}
