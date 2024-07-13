package sqlc

import (
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestGetTransfer(t *testing.T) {
	transfer, err := testQueries.GetTransfer(context.Background(), 1)
	require.NoError(t, err)
	require.NotEmpty(t, transfer)
}
