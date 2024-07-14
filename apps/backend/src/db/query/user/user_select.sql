-- name: SelectUser :one
SELECT * from "user" WHERE "id" = $1;


-- name: SelectUserInEmail :many
SELECT * from "user" WHERE "email" IN ($1);
