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