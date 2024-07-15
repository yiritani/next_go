-- name: DeleteSystemUserRelation :one
DELETE FROM "system_user_relation" WHERE system_id = $1 AND user_id = $2 RETURNING *;
