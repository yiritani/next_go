-- ユーザーテーブル
CREATE TABLE users (
   user_id INTEGER PRIMARY KEY,
   username TEXT NOT NULL,
   email TEXT NOT NULL UNIQUE
);

-- 製品テーブル
CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name TEXT NOT NULL,
  price REAL NOT NULL,
  stock_quantity INTEGER NOT NULL
);

-- 注文テーブル
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    order_date TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 支払いテーブル
CREATE TABLE payments (
  payment_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  payment_date TEXT NOT NULL,
  amount REAL NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);