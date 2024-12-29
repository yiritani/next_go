#!/bin/sh
set -e

echo "Running migrations..."
migrate -path ./src/db/migration \
  -database "sqlite3://./db.sqlite" \
  up
echo "Migrations done."

echo "Loading fixtures..."
sqlite3 db.sqlite < ./src/db/migration/fixture/000001_init_schema.up.sql
echo "Fixtures loaded."

exec "$@"