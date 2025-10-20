CREATE OR REPLACE VIEW v_lane_performance AS
SELECT
  seller_state,
  customer_state,
  COUNT(*)                                           AS orders,
  ROUND(AVG(is_on_time)::numeric, 3)                 AS on_time_rate,
  ROUND(1 - AVG(is_on_time)::numeric, 3)             AS late_rate,
  ROUND(AVG(lead_time_days)::numeric, 2)             AS avg_lead_time_days,
  -- Robust central tendency (median) to avoid outlier noise
  percentile_cont(0.5) WITHIN GROUP (ORDER BY handling_days) AS p50_handling_days,
  percentile_cont(0.75) WITHIN GROUP (ORDER BY handling_days) AS p75_handling_days,
  percentile_cont(0.5) WITHIN GROUP (ORDER BY transit_days)  AS p50_transit_days,
  percentile_cont(0.75) WITHIN GROUP (ORDER BY transit_days)  AS p75_transit_days
FROM v_delivery_facts_plus
GROUP BY seller_state, customer_state;

-- slowest 10 shipping lanes
SELECT
  seller_state,
  customer_state,
  orders,
  ROUND(on_time_rate::numeric, 3) AS on_time_rate,
  ROUND(late_rate::numeric, 3)    AS late_rate,
  avg_lead_time_days,
  ROUND(p50_handling_days::numeric, 2) AS p50_handling_days,
  ROUND(p75_handling_days::numeric, 2) AS p75_handling_days,
  ROUND(p50_transit_days::numeric, 2)  AS p50_transit_days,
  ROUND(p75_transit_days::numeric, 2)  AS p75_transit_days
FROM v_lane_performance   -- replace with mv_lane_performance if using materialized view
WHERE orders >= 250
  AND on_time_rate < 0.90
ORDER BY on_time_rate ASC, orders DESC
LIMIT 10;

-- identifying significant transit delays 
SELECT *
FROM v_lane_performance
WHERE orders >= 300
  AND p50_transit_days > p50_handling_days * 1.5
ORDER BY (p50_transit_days - p50_handling_days) DESC
LIMIT 20;


