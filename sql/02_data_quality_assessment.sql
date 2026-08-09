USE olist_analytics;

-- 1. Row counts
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers;


-- 2. Duplicate orders
SELECT order_id, COUNT(*) AS count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- 3. Duplicate customers
SELECT customer_id, COUNT(*) AS count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 4. Duplicate products
SELECT product_id, COUNT(*) AS count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;


-- 5. Order status distribution
SELECT
    order_status,
    COUNT(*) AS orders
FROM orders
GROUP BY order_status
ORDER BY orders DESC;


-- 6. Missing delivery dates
SELECT
    COUNT(*) AS missing_delivery_dates
FROM orders
WHERE order_delivered_customer_date IS NULL;


-- 7. Negative prices
SELECT COUNT(*) AS negative_prices
FROM order_items
WHERE price < 0;


-- 8. Negative freight
SELECT COUNT(*) AS negative_freight
FROM order_items
WHERE freight_value < 0;


-- 9. Invalid review scores
SELECT *
FROM order_reviews
WHERE review_score NOT BETWEEN 1 AND 5;


-- 10. Referential integrity - order items without orders
SELECT COUNT(*) AS orphan_order_items
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;