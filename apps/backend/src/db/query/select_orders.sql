-- name: GetOrderByUserID :many
SELECT users.user_id, order_id, product_id , quantity, order_date
FROM orders
INNER JOIN users ON orders.user_id = users.user_id
WHERE orders.user_id = ?;
