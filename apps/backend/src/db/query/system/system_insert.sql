-- name: InsertSystem :one
INSERT INTO "system" (system_name) VALUES ($1) RETURNING *;

-- name: InsertSystemUserRelation :one
INSERT INTO "system_user_relation" (system_id, user_id, system_role) VALUES ($1, $2, $3) RETURNING *;
