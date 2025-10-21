WITH seller_kpis AS (
  SELECT seller_id,
         COUNT(*) AS delivered_orders,
         ROUND(AVG(is_on_time)::numeric, 3) AS on_time_rate,
         percentile_cont(0.5) WITHIN GROUP (ORDER BY handling_days) AS p50_handling_days,
         percentile_cont(0.5) WITHIN GROUP (ORDER BY transit_days)  AS p50_transit_days
  FROM v_delivery_facts_plus
  GROUP BY seller_id
)

SELECT seller_id,
       delivered_orders,
       ROUND(on_time_rate, 3) AS on_time_rate,
       ROUND(p50_handling_days::numeric, 2) AS p50_handling_days,
       ROUND(p50_transit_days::numeric, 2) AS p50_transit_days
FROM seller_kpis
WHERE delivered_orders >= 200
ORDER BY p50_handling_days DESC, delivered_orders DESC
LIMIT 20;
