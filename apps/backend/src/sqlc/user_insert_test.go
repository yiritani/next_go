package sqlc

import (
	"context"
	"github.com/stretchr/testify/require"
	"testing"
	"tutorial.sqlc.dev/app/src/lib"
)

func insertTestUser(t *testing.T) User {
	ctx := context.Background()
	randEmail := lib.CreateRandomString(10) + "@test.com"
	randUsername := lib.CreateRandomString(10)
	user, err := testQueries.InsertUser(ctx, InsertUserParams{
		Email: randEmail,
		Name:  randUsername,
	})

	require.NoError(t, err)
	require.NotEmpty(t, user)
	require.Equal(t, randEmail, user.Email)
	require.Equal(t, randUsername, user.Name)

	return user
}

func TestQueries_InsertUser(t *testing.T) {
	insertTestUser(t)
}
