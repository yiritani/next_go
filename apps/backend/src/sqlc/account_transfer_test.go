package sqlc

import (
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestGetAccountTransfers(t *testing.T) {
	ctx := context.Background()
	accountTransfers, err := testQueries.GetAccountTransfers(ctx, 1)

	require.NoError(t, err)
	require.Len(t, accountTransfers, 1)
}
