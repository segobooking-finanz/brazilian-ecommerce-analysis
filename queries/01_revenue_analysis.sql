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
