-- ============================================
-- CUSTOMER & GEOGRAPHIC ANALYSIS
-- Brazilian E-Commerce
-- Author: Simón Segovia
-- Description: Customer behavior, retention,
--              and geographic distribution
-- ============================================

-- 1. Customer Repeat Purchase Rate
WITH customer_orders AS (
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT 
    CASE 
        WHEN total_orders = 1 THEN '1 order'
        WHEN total_orders = 2 THEN '2 orders'
        WHEN total_orders = 3 THEN '3 orders'
        ELSE '4+ orders'
    END                                             AS order_frequency,
    COUNT(*)                                        AS total_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER()::numeric, 2) AS pct_of_customers
FROM customer_orders
GROUP BY order_frequency
ORDER BY total_customers DESC;

-- 2. Revenue by Customer State with Avg Order Value
SELECT 
    c.customer_state,
    COUNT(DISTINCT c.customer_unique_id)            AS unique_customers,
    COUNT(DISTINCT o.order_id)                      AS total_orders,
    ROUND(SUM(op.payment_value)::numeric, 2)        AS total_revenue,
    ROUND(AVG(op.payment_value)::numeric, 2)        AS avg_order_value,
    ROUND(100.0 * SUM(op.payment_value) / 
        SUM(SUM(op.payment_value)) OVER()::numeric, 2) AS revenue_share_pct
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. Average Order Value by City (Top 20)
SELECT 
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT o.order_id)                      AS total_orders,
    ROUND(AVG(op.payment_value)::numeric, 2)        AS avg_order_value,
    ROUND(SUM(op.payment_value)::numeric, 2)        AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY c.customer_city, c.customer_state
HAVING COUNT(DISTINCT o.order_id) > 100
ORDER BY avg_order_value DESC
LIMIT 20;

-- 4. Customer Acquisition by Month
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    COUNT(DISTINCT c.customer_unique_id)             AS new_customers,
    ROUND(SUM(op.payment_value)::numeric, 2)         AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments op ON o.order_id = op.order_id
WHERE o.order_purchase_timestamp IS NOT NULL
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY month;

-- 5. Order Status Distribution
SELECT 
    order_status,
    COUNT(*)                                        AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER()::numeric, 2) AS pct_of_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 6. High Value Customers (Top 1%)
WITH customer_revenue AS (
    SELECT 
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,
        COUNT(DISTINCT o.order_id)                  AS total_orders,
        ROUND(SUM(op.payment_value)::numeric, 2)    AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_payments op ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id, c.customer_city, c.customer_state
)
SELECT 
    customer_unique_id,
    customer_city,
    customer_state,
    total_orders,
    total_spent
FROM customer_revenue
WHERE total_spent >= (
    SELECT PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY total_spent)
    FROM customer_revenue
)
ORDER BY total_spent DESC
LIMIT 20;

-- 7. Delivery Time by State
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id)                      AS total_orders,
    ROUND(AVG(
        EXTRACT(DAY FROM (o.order_delivered_customer_date - 
        o.order_purchase_timestamp))
    )::numeric, 1)                                  AS avg_delivery_days,
    ROUND(AVG(r.review_score)::numeric, 2)          AS avg_review_score
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days ASC;
