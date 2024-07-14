#!/bin/bash

POSTGRES_USER=${POSTGRES_USER:-postgres}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-password}
POSTGRES_DB=${POSTGRES_DB:-postgres}
POSTGRES_HOST=${POSTGRES_HOST:-localhost}
POSTGRES_PORT=${POSTGRES_PORT:-5432}

while getopts "tud" opt; do
  case $opt in
    t)
      # Test environment variables
      POSTGRES_USER=${TEST_POSTGRES_USER:-postgres}
      POSTGRES_PASSWORD=${TEST_POSTGRES_PASSWORD:-test_password}
      POSTGRES_DB=${TEST_POSTGRES_DB:-postgres}
      POSTGRES_HOST=${TEST_POSTGRES_HOST:-test_db}
      POSTGRES_PORT=${TEST_POSTGRES_SHELL_PORT:-54321}
      ;;
    u)
      ACTION="up"
      ;;
    d)
      ACTION="down"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

ACTION=${ACTION:-"error"}

migrate -path src/db/migration -database "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}?sslmode=disable" -verbose $ACTION

#if [ "$1" == "-t" ]; then
#  migrate -path src/db/migration -database "postgresql://${TEST_POSTGRES_USER}:${TEST_POSTGRES_PASSWORD}@${TEST_POSTGRES_HOST}:${TEST_POSTGRES_PORT}/${TEST_POSTGRES_DB}?sslmode=disable" -verbose up
#else
#  migrate -path src/db/migration -database "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}?sslmode=disable" -verbose up
#fi
