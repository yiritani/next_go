-- name: InsertSystem :one
INSERT INTO "system" (system_name) VALUES ($1) RETURNING *;

-- name: InsertSystemUserRelation :one
INSERT INTO "systemUserRelation" (system_id, user_id) VALUES ($1, $2) RETURNING *;
