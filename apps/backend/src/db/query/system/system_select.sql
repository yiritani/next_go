-- name: SelectSystem :one
SELECT * from "system" WHERE "id" = $1;

-- name: SelectSystemUsers :many
SELECT
"system".id as system_id,
"user".id as user_id,
"user".name as user_name,
"user".email as email,
"system_user_relation".system_role as system_role
from "system"
INNER JOIN "system_user_relation" ON "system"."id" = "system_user_relation"."system_id"
INNER JOIN "user" ON "system_user_relation"."user_id" = "user"."id"
WHERE "system"."id" = $1;

-- name: ListSystems :many
SELECT * from "system"
LIMIT $1
OFFSET $2;
