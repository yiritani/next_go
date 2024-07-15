-- name: SelectUser :one
SELECT * from "user" WHERE "id" = $1;


-- name: SelectUserInEmail :many
SELECT * from "user" WHERE "email" = ANY($1::varchar[]);

-- name: SelectUserLikeEmail :many
SELECT * from "user" WHERE "email" LIKE $1;
