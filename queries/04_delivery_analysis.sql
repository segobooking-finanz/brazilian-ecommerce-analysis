-- ============================================
-- DELIVERY & OPERATIONS ANALYSIS
-- Brazilian E-Commerce
-- Author: Simón Segovia
-- Description: Logistics performance, delivery
--              times, and operational efficiency
-- ============================================

-- 1. Overall Delivery Performance
SELECT
    COUNT(*)                                        AS total_orders,
    ROUND(AVG(
        EXTRACT(DAY FROM (order_delivered_customer_date - 
        order_purchase_timestamp))
    )::numeric, 1)                                  AS avg_delivery_days,
    ROUND(AVG(
        EXTRACT(DAY FROM (order_estimated_delivery_date - 
        order_purchase_timestamp))
    )::numeric, 1)                                  AS avg_estimated_days,
    ROUND(AVG(
        EXTRACT(DAY FROM (order_delivered_customer_date - 
        order_estimated_delivery_date))
    )::numeric, 1)                                  AS avg_days_vs_estimate,
    ROUND(100.0 * SUM(CASE 
        WHEN order_delivered_customer_date <= order_estimated_delivery_date 
        THEN 1 ELSE 0 END) / COUNT(*)::numeric, 2)  AS on_time_rate_pct
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- 2. Delivery Performance by Month
SELECT
    DATE_TRUNC('month', order_purchase_timestamp)   AS month,
    COUNT(*)                                        AS total_orders,
    ROUND(AVG(
        EXTRACT(DAY FROM (order_delivered_customer_date - 
        order_purchase_timestamp))
    )::numeric, 1)                                  AS avg_delivery_days,
    ROUND(100.0 * SUM(CASE 
        WHEN order_delivered_customer_date <= order_estimated_delivery_date 
        THEN 1 ELSE 0 END) / COUNT(*)::numeric, 2)  AS on_time_rate_pct
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
AND order_purchase_timestamp IS NOT NULL
GROUP BY DATE_TRUNC('month', order_purchase_timestamp)
ORDER BY month;

-- 3. Delivery Time Distribution
SELECT
    CASE
        WHEN EXTRACT(DAY FROM (order_delivered_customer_date - 
             order_purchase_timestamp)) <= 7  THEN '0-7 days'
        WHEN EXTRACT(DAY FROM (order_delivered_customer_date - 
             order_purchase_timestamp)) <= 14 THEN '8-14 days'
        WHEN EXTRACT(DAY FROM (order_delivered_customer_date - 
             order_purchase_timestamp)) <= 21 THEN '15-21 days'
        WHEN EXTRACT(DAY FROM (order_delivered_customer_date - 
             order_purchase_timestamp)) <= 30 THEN '22-30 days'
        ELSE '30+ days'
    END                                             AS delivery_range,
    COUNT(*)                                        AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER()::numeric, 2) AS pct_of_orders,
    ROUND(AVG(review_score)::numeric, 2)            AS avg_review_score
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY delivery_range
ORDER BY MIN(EXTRACT(DAY FROM (order_delivered_customer_date - 
             order_purchase_timestamp)));

-- 4. Approval to Carrier Time Analysis
SELECT
    DATE_TRUNC('month', order_purchase_timestamp)   AS month,
    ROUND(AVG(
        EXTRACT(HOUR FROM (order_approved_at - 
        order_purchase_timestamp))
    )::numeric, 1)                                  AS avg_hours_to_approval,
    ROUND(AVG(
        EXTRACT(DAY FROM (order_delivered_carrier_date - 
        order_approved_at))
    )::numeric, 1)                                  AS avg_days_to_carrier,
    ROUND(AVG(
        EXTRACT(DAY FROM (order_delivered_customer_date - 
        order_delivered_carrier_date))
    )::numeric, 1)                                  AS avg_days_carrier_to_customer
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
AND order_purchase_timestamp IS NOT NULL
AND order_approved_at IS NOT NULL
AND order_delivered_carrier_date IS NOT NULL
GROUP BY DATE_TRUNC('month', order_purchase_timestamp)
ORDER BY month;

-- 5. Late Deliveries by State
SELECT
    c.customer_state,
    COUNT(*)                                        AS total_orders,
    SUM(CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 1 ELSE 0 END)                          AS late_orders,
    ROUND(100.0 * SUM(CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date 
        THEN 1 ELSE 0 END) / COUNT(*)::numeric, 2)  AS late_rate_pct,
    ROUND(AVG(r.review_score)::numeric, 2)          AS avg_review_score
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY late_rate_pct DESC;

-- 6. Revenue Impact of Delivery Performance
WITH delivery_performance AS (
    SELECT
        o.order_id,
        CASE
            WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - 
                 o.order_purchase_timestamp)) <= 7  THEN '0-7 days'
            WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - 
                 o.order_purchase_timestamp)) <= 14 THEN '8-14 days'
            WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - 
                 o.order_purchase_timestamp)) <= 21 THEN '15-21 days'
            WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - 
                 o.order_purchase_timestamp)) <= 30 THEN '22-30 days'
            ELSE '30+ days'
        END AS delivery_range
    FROM orders o
    WHERE o.order_delivered_customer_date IS NOT NULL
)
SELECT
    dp.delivery_range,
    COUNT(DISTINCT dp.order_id)                     AS total_orders,
    ROUND(SUM(op.payment_value)::numeric, 2)        AS total_revenue,
    ROUND(AVG(op.payment_value)::numeric, 2)        AS avg_order_value,
    ROUND(AVG(r.review_score)::numeric, 2)          AS avg_review_score
FROM delivery_performance dp
JOIN order_payments op ON dp.order_id = op.order_id
JOIN order_reviews r ON dp.order_id = r.order_id
GROUP BY dp.delivery_range
ORDER BY MIN(
    CASE dp.delivery_range
        WHEN '0-7 days'   THEN 1
        WHEN '8-14 days'  THEN 2
        WHEN '15-21 days' THEN 3
        WHEN '22-30 days' THEN 4
        ELSE 5
    END
);
