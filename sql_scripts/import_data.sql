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