package sqlc

import (
	"context"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestGetEntry(t *testing.T) {
	entries, err := testQueries.GetEntry(context.Background(), 1)
	require.NoError(t, err)
	require.NotEmpty(t, entries)
}

func TestListEntries(t *testing.T) {
	entries, err := testQueries.ListEntries(context.Background(), ListEntriesParams{
		Limit:  5,
		Offset: 5,
	})
	require.NoError(t, err)
	require.NotEmpty(t, entries)
}
