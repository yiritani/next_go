-- name: CreateSystem :one
INSERT INTO "system" (system_name) VALUES ($1) RETURNING *;