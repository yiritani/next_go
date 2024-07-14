-- name: SelectSystem :one
SELECT * from "system" WHERE "id" = $1;

-- name: SelectSystemUsers :many
SELECT
"system".id as system_id,
"user".id as user_id,
"user".name as user_name,
"user".email as email
from "system"
INNER JOIN "systemUserRelation" ON "system"."id" = "systemUserRelation"."system_id"
INNER JOIN "user" ON "systemUserRelation"."user_id" = "user"."id"
WHERE "system"."id" = $1;

-- name: ListSystems :many
SELECT * from "system"
LIMIT $1
OFFSET $2;
