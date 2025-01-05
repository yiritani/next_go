-- ユーザーテーブルにデータを挿入
INSERT INTO users (user_id, username, email) VALUES
                                                 (1, 'Alice', 'alice@example.com'),
                                                 (2, 'Bob', 'bob@example.com'),
                                                 (3, 'Charlie', 'charlie@example.com'),
                                                 (4, 'Diana', 'diana@example.com');

-- 製品テーブルにデータを挿入
INSERT INTO products (product_id, product_name, price, stock_quantity) VALUES
                                                                           (101, 'Laptop', 1200, 10),
                                                                           (102, 'Smartphone', 800, 20),
                                                                           (103, 'Tablet', 400, 15),
                                                                           (104, 'Headphones', 150, 50);

-- 注文テーブルにデータを挿入
INSERT INTO orders (order_id, user_id, product_id, order_date, quantity) VALUES
                                                                             (1001, 1, 101, '2023-05-01', 1),
                                                                             (1002, 2, 102, '2023-05-03', 2),
                                                                             (1003, 1, 104, '2023-05-05', 1),
                                                                             (1004, 3, 103, '2023-05-07', 3),
                                                                             (1005, 1, 101, '2023-05-07', 3);

-- 支払いテーブルにデータを挿入
INSERT INTO payments (payment_id, order_id, payment_date, amount) VALUES
                                                                      (5001, 1001, '2023-05-02', 1200),
                                                                      (5002, 1002, '2023-05-04', 1600),
                                                                      (5003, 1003, '2023-05-06', 150),
                                                                      (5004, 1004, '2023-05-08', 1200);