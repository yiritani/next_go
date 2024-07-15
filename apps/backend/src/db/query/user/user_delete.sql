-- name: DeleteUser :one
DELETE FROM "user" WHERE id = $1 RETURNING *;
