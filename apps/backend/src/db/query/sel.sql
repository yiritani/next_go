-- name: GetUser :one
SELECT * from "user" WHERE "id" = $1;

-- name: GetSystem :one
SELECT * from "system" WHERE "id" = $1;


-- name: GetSystemUsers :many
SELECT
"system".id as system_id,
"user".id as user_id,
"user".name as user_name
from "system"
INNER JOIN "user" ON "system"."id" = "user"."system_id";