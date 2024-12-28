-- name: InsertUser :one
INSERT INTO users (
    username, email
) VALUES (
             ?, ?
         )
    RETURNING user_id, username, email;