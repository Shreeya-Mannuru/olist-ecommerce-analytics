USE olist_analytics;

-- Total Revenue
SELECT ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered';


-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;


-- Total Customers
SELECT COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;


-- Average Order Value
SELECT ROUND(
    SUM(oi.price) / COUNT(DISTINCT o.order_id), 2
) AS average_order_value
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered';


-- Average Basket Size
SELECT ROUND(
    COUNT(*) / COUNT(DISTINCT o.order_id), 2
) AS average_basket_size
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered';


-- Average Delivery Days
SELECT ROUND(AVG(delivery_days), 2) AS average_delivery_days
FROM orders
WHERE order_status = 'delivered';


-- Cancellation Rate
SELECT ROUND(
    100.0 * SUM(order_status = 'canceled') / COUNT(*),
    2
) AS cancellation_rate
FROM orders;


-- Average Review Score
SELECT ROUND(AVG(review_score), 2) AS average_review_score
FROM order_reviews;