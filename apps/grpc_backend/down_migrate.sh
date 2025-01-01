#!/bin/sh
set -e

echo "Down migrations..."
yes | migrate -path ./src/db/migration \
  -database "sqlite3://./db.sqlite" \
  down
echo "Migrations done."

exec "$@"