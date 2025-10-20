CREATE TABLE IF NOT EXISTS olist_orders (
  order_id TEXT PRIMARY KEY,
  customer_id TEXT,
  order_status TEXT,
  order_purchase_timestamp TIMESTAMP,
  order_approved_at TIMESTAMP,
  order_delivered_carrier_date TIMESTAMP,    -- may be NULL for some rows
  order_delivered_customer_date TIMESTAMP,   -- may be NULL for some rows
  order_estimated_delivery_date TIMESTAMP    
);

CREATE TABLE IF NOT EXISTS olist_order_items (
  order_id TEXT,
  order_item_id INT,
  product_id TEXT,
  seller_id TEXT,
  shipping_limit_date TIMESTAMP,
  price NUMERIC(12,2),
  freight_value NUMERIC(12,2),
  PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE IF NOT EXISTS olist_customers (
  customer_id TEXT PRIMARY KEY,
  customer_unique_id TEXT,
  customer_zip_code_prefix INT,
  customer_city VARCHAR(50),
  customer_state VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS olist_sellers (
  seller_id TEXT PRIMARY KEY,
  seller_zip_code_prefix VARCHAR(10),
  seller_city TEXT,
  seller_state VARCHAR(2)
);

-- SELECT * FROM olist_sellers LIMIT 10;

CREATE TABLE IF NOT EXISTS olist_order_reviews (
  review_id TEXT,
  order_id TEXT,
  review_score INT,
  review_comment_title TEXT,
  review_comment_message TEXT,
  review_creation_date TIMESTAMP,
  review_answer_timestamp TIMESTAMP
);

CREATE TABLE IF NOT EXISTS olist_products (
  product_id TEXT PRIMARY KEY,
  product_category_name TEXT,
  product_name_length INT,
  product_description_length INT,
  product_photos_qty INT,
  product_weight_g INT,
  product_length_cm INT,
  product_height_cm INT,
  product_width_cm INT
);

CREATE TABLE IF NOT EXISTS product_category_name_translation (
  product_category_name TEXT PRIMARY KEY,
  product_category_name_english TEXT
);


