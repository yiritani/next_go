-- name: InsertOrder :one
INSERT INTO orders (
    user_id, product_id, quantity, order_date
) VALUES (
                ?, ?, ?, ?
         )
    RETURNING order_id, user_id, product_id, quantity, order_date;
