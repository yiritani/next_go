-- name: InsertUser :one
INSERT INTO "user" (name, email) VALUES ($1, $2) RETURNING *;
