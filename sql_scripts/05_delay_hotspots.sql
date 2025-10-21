WITH base AS ( 
    SELECT seller_id, seller_state, customer_state, 
    COUNT(*) AS orders, AVG(1 - is_on_time)::numeric  AS late_rate,
    percentile_cont(0.5) WITHIN GROUP (ORDER BY handling_days) AS p50_handling_days,
    percentile_cont(0.5) WITHIN GROUP (ORDER BY transit_days)  AS p50_transit_days
    FROM v_delivery_facts_plus
    GROUP BY seller_id, seller_state, customer_state 
)


SELECT seller_id, seller_state, customer_state, orders,
    ROUND(late_rate, 3) AS late_rate, 
    ROUND(p50_handling_days::numeric, 2) AS p50_handling_days,
    ROUND(p50_transit_days::numeric, 2)  AS p50_transit_days
    FROM base
    WHERE orders >= 50    -- enough traffic to matter
    AND late_rate >= 0.20   -- tweak threshold to your SLA
    ORDER BY late_rate DESC, orders DESC
    LIMIT 20;
