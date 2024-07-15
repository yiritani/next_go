package sqlc

import (
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestQueries_SelectUserInEmail(t *testing.T) {
	insertedUser := insertTestUser(t)
	insertedUser2 := insertTestUser(t)
	selectedUser, err := testQueries.SelectUserInEmail(context.Background(), []string{insertedUser.Email, insertedUser2.Email})
	require.NoError(t, err)
	require.NotEmpty(t, selectedUser)
	require.True(t, len(selectedUser) > 0)
}

func TestQueries_SelectUserLikeEmail(t *testing.T) {
	insertTestUser(t)
	selectedUser, err := testQueries.SelectUserLikeEmail(context.Background(), "%@%")
	require.NoError(t, err)
	require.NotEmpty(t, selectedUser)
	require.Equal(t, len(selectedUser) > 0, true)
}
