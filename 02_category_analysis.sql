-- ============================================
-- CATEGORY & PRODUCT ANALYSIS
-- Brazilian E-Commerce
-- Author: Simón Segovia
-- Description: Deep dive into product categories,
--              pricing, and seller performance
-- ============================================

-- 1. Full Category Revenue Breakdown
SELECT 
    ct.product_category_name_english           AS category,
    COUNT(DISTINCT oi.order_id)                AS total_orders,
    COUNT(DISTINCT oi.product_id)              AS unique_products,
    ROUND(SUM(oi.price)::numeric, 2)           AS total_revenue,
    ROUND(AVG(oi.price)::numeric, 2)           AS avg_price,
    ROUND(MIN(oi.price)::numeric, 2)           AS min_price,
    ROUND(MAX(oi.price)::numeric, 2)           AS max_price,
    ROUND(100.0 * SUM(oi.price) / 
        SUM(SUM(oi.price)) OVER()::numeric, 2) AS revenue_share_pct
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_revenue DESC;

-- 2. Category Revenue vs Freight Cost
SELECT 
    ct.product_category_name_english           AS category,
    ROUND(AVG(oi.price)::numeric, 2)           AS avg_price,
    ROUND(AVG(oi.freight_value)::numeric, 2)   AS avg_freight,
    ROUND(100.0 * AVG(oi.freight_value) / 
        NULLIF(AVG(oi.price), 0)::numeric, 2)  AS freight_to_price_pct,
    COUNT(*)                                   AS total_items
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY freight_to_price_pct DESC
LIMIT 15;

-- 3. Top Categories by Average Review Score
SELECT 
    ct.product_category_name_english           AS category,
    ROUND(AVG(r.review_score)::numeric, 2)     AS avg_review_score,
    COUNT(DISTINCT o.order_id)                 AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2)           AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
JOIN orders o ON oi.order_id = o.order_id
JOIN order_reviews r ON o.order_id = r.order_id
GROUP BY ct.product_category_name_english
HAVING COUNT(DISTINCT o.order_id) > 100
ORDER BY avg_review_score DESC
LIMIT 15;

-- 4. Seller Performance Tier Analysis
WITH seller_revenue AS (
    SELECT 
        s.seller_id,
        s.seller_state,
        COUNT(DISTINCT oi.order_id)            AS total_orders,
        ROUND(SUM(oi.price)::numeric, 2)       AS total_revenue,
        ROUND(AVG(oi.price)::numeric, 2)       AS avg_price,
        ROUND(AVG(r.review_score)::numeric, 2) AS avg_review
    FROM order_items oi
    JOIN sellers s ON oi.seller_id = s.seller_id
    JOIN orders o ON oi.order_id = o.order_id
    JOIN order_reviews r ON o.order_id = r.order_id
    GROUP BY s.seller_id, s.seller_state
)
SELECT 
    CASE 
        WHEN total_revenue >= 100000 THEN 'Platinum'
        WHEN total_revenue >= 50000  THEN 'Gold'
        WHEN total_revenue >= 10000  THEN 'Silver'
        ELSE 'Bronze'
    END                                        AS seller_tier,
    COUNT(*)                                   AS total_sellers,
    ROUND(AVG(total_revenue)::numeric, 2)      AS avg_revenue,
    ROUND(AVG(avg_review)::numeric, 2)         AS avg_review_score,
    ROUND(SUM(total_revenue)::numeric, 2)      AS tier_total_revenue
FROM seller_revenue
GROUP BY seller_tier
ORDER BY avg_revenue DESC;

-- 5. Products with Highest Freight to Price Ratio
-- (identifies logistically inefficient products)
SELECT 
    ct.product_category_name_english           AS category,
    ROUND(AVG(oi.price)::numeric, 2)           AS avg_price,
    ROUND(AVG(oi.freight_value)::numeric, 2)   AS avg_freight,
    ROUND(AVG(oi.freight_value) / 
        NULLIF(AVG(oi.price), 0)::numeric, 4)  AS freight_ratio,
    COUNT(*)                                   AS total_items
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
HAVING COUNT(*) > 50
ORDER BY freight_ratio DESC
LIMIT 10;

-- 6. Monthly Revenue by Top 5 Categories
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ct.product_category_name_english                AS category,
    ROUND(SUM(oi.price)::numeric, 2)                AS monthly_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
JOIN orders o ON oi.order_id = o.order_id
WHERE ct.product_category_name_english IN (
    'health_beauty', 'watches_gifts', 
    'bed_bath_table', 'sports_leisure', 
    'computers_accessories'
)
AND o.order_purchase_timestamp IS NOT NULL
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp),
         ct.product_category_name_english
ORDER BY month, monthly_revenue DESC;
