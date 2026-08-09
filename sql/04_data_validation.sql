USE olist_analytics;

-- Validate delivered orders
SELECT COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'delivered';


-- Validate positive prices
SELECT COUNT(*) AS invalid_prices
FROM order_items
WHERE price <= 0;


-- Validate review scores
SELECT COUNT(*) AS invalid_reviews
FROM order_reviews
WHERE review_score NOT BETWEEN 1 AND 5;


-- Validate delivery days
SELECT
    MIN(delivery_days) AS minimum_delivery_days,
    MAX(delivery_days) AS maximum_delivery_days,
    AVG(delivery_days) AS average_delivery_days
FROM orders
WHERE order_status = 'delivered';


-- Check orphan records
SELECT COUNT(*) AS orphan_items
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;