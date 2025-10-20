CREATE OR REPLACE VIEW v_delivery_facts_plus AS
WITH order_seller AS (
 -- Ensure one row per order × seller (orders can have multiple items per seller)
 SELECT DISTINCT order_id, seller_id
 FROM olist_order_items
)
SELECT
 os.order_id,
 os.seller_id,
 o.customer_id,
 c.customer_state,
 s.seller_state,
 
 -- Milestones
 o.order_approved_at,
 o.order_delivered_carrier_date,      -- when seller handed off to carrier
 o.order_delivered_customer_date,     -- when customer received it
 o.order_estimated_delivery_date,     -- promised latest date
 
 -- KPIs (in days)
 ROUND(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_approved_at))/86400.0, 2)
   AS lead_time_days,
 ROUND(EXTRACT(EPOCH FROM (o.order_delivered_carrier_date - o.order_approved_at))/86400.0, 2)
   AS handling_days,
 ROUND(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_delivered_carrier_date))/86400.0, 2)
   AS transit_days,
 ROUND(EXTRACT(EPOCH FROM (o.order_estimated_delivery_date - o.order_approved_at))/86400.0, 2)
   AS promised_days,
 GREATEST(
   ROUND(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date))/86400.0, 2),
   0
 ) AS lateness_days,
 
 CASE WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 1 ELSE 0 END
   AS is_on_time
FROM olist_orders o
JOIN order_seller    os ON os.order_id = o.order_id
JOIN olist_customers c  ON c.customer_id = o.customer_id
JOIN olist_sellers   s  ON s.seller_id   = os.seller_id
WHERE o.order_status = 'delivered'
 AND o.order_approved_at IS NOT NULL
 AND o.order_delivered_customer_date IS NOT NULL
 AND o.order_estimated_delivery_date IS NOT NULL
 AND o.order_delivered_carrier_date >= o.order_approved_at
 AND o.order_delivered_customer_date >= o.order_delivered_carrier_date;