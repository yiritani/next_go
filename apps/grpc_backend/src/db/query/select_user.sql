-- name: GetUserByID :one
SELECT user_id, username, email
FROM users
WHERE user_id = ?;

-- name: ListUsers :many
SELECT user_id, username, email
FROM users
ORDER BY user_id ASC;