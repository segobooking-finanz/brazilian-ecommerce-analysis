-- ============================================
-- REVENUE ANALYSIS - Brazilian E-Commerce
-- Author: Simón Segovia
-- Description: Key financial KPIs and revenue
--              breakdown by payment method
-- ============================================

-- 1. Overall Revenue KPIs
SELECT 
    COUNT(*)                    AS total_transactions,
    ROUND(SUM(payment_value)::numeric, 2)   AS total_revenue,
    ROUND(AVG(payment_value)::numeric, 2)   AS avg_order_value,
    ROUND(MAX(payment_value)::numeric, 2)   AS max_payment,
    ROUND(MIN(payment_value)::numeric, 2)   AS min_payment
FROM order_payments
WHERE payment_value > 0;

-- 2. Revenue by Payment Method
SELECT 
    payment_type,
    COUNT(*)                                AS total_transactions,
    ROUND(SUM(payment_value)::numeric, 2)   AS total_revenue,
    ROUND(AVG(payment_value)::numeric, 2)   AS avg_order_value,
    ROUND(100.0 * SUM(payment_value) / 
        SUM(SUM(payment_value)) OVER()::numeric, 2) AS revenue_share_pct
FROM order_payments
WHERE payment_value > 0
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- 3. Revenue by Number of Installments
SELECT 
    payment_installments,
    COUNT(*)                                AS total_transactions,
    ROUND(SUM(payment_value)::numeric, 2)   AS total_revenue,
    ROUND(AVG(payment_value)::numeric, 2)   AS avg_order_value
FROM order_payments
WHERE payment_value > 0
GROUP BY payment_installments
ORDER BY payment_installments;


-- 4. Monthly Revenue Trend
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    COUNT(DISTINCT o.order_id)                       AS total_orders,
    ROUND(SUM(op.payment_value)::numeric, 2)         AS monthly_revenue,
    ROUND(AVG(op.payment_value)::numeric, 2)         AS avg_order_value
FROM orders o
JOIN order_payments op ON o.order_id = op.order_id
WHERE o.order_purchase_timestamp IS NOT NULL
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY month;

-- 5. Month over Month Revenue Growth
WITH monthly_revenue AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        ROUND(SUM(op.payment_value)::numeric, 2) AS revenue
    FROM orders o
    JOIN order_payments op ON o.order_id = op.order_id
    WHERE o.order_purchase_timestamp IS NOT NULL
    GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month)) / 
        NULLIF(LAG(revenue) OVER (ORDER BY month), 0), 2) AS mom_growth_pct
FROM monthly_revenue
ORDER BY month;

-- 6. Top 10 Product Categories by Revenue
SELECT 
    ct.product_category_name_english AS category,
    COUNT(DISTINCT oi.order_id)                     AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2)                AS total_revenue,
    ROUND(AVG(oi.price)::numeric, 2)                AS avg_price,
    ROUND(100.0 * SUM(oi.price) / 
        SUM(SUM(oi.price)) OVER()::numeric, 2)      AS revenue_share_pct
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;

-- 7. Average Delivery Time and Impact on Reviews
SELECT 
    ROUND(AVG(
        EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp))
    )::numeric, 1)                                  AS avg_delivery_days,
    r.review_score,
    COUNT(*)                                        AS total_reviews
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score DESC;

-- 8. Top 10 Sellers by Revenue
SELECT 
    s.seller_id,
    s.seller_city,
    s.seller_state,
    COUNT(DISTINCT oi.order_id)                     AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2)                AS total_revenue,
    ROUND(AVG(oi.price)::numeric, 2)                AS avg_price
FROM order_items oi
JOIN sellers s ON oi.seller_id = s.seller_id
GROUP BY s.seller_id, s.seller_city, s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;

-- 9. Customer Concentration by State
SELECT 
    customer_state,
    COUNT(DISTINCT customer_id)                     AS total_customers,
    ROUND(100.0 * COUNT(DISTINCT customer_id) / 
        SUM(COUNT(DISTINCT customer_id)) OVER()::numeric, 2) AS customer_share_pct
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 10;

-- 10. Revenue vs Estimated Delivery Performance
SELECT
    CASE 
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date 
        THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*)                                        AS total_orders,
    ROUND(AVG(r.review_score)::numeric, 2)          AS avg_review_score,
    ROUND(SUM(op.payment_value)::numeric, 2)        AS total_revenue
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
JOIN order_payments op ON o.order_id = op.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status
ORDER BY delivery_status;
