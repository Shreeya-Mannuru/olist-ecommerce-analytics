USE olist_analytics;

-- Verify missing product categories
SELECT COUNT(*) AS missing_categories
FROM products
WHERE product_category_name IS NULL;


-- Verify missing review titles
SELECT COUNT(*) AS missing_review_titles
FROM order_reviews
WHERE review_comment_title IS NULL;


-- Verify missing review comments
SELECT COUNT(*) AS missing_review_comments
FROM order_reviews
WHERE review_comment_message IS NULL;


-- Verify delivery dates remain NULL where unavailable
SELECT
    order_status,
    COUNT(*) AS orders
FROM orders
WHERE order_delivered_customer_date IS NULL
GROUP BY order_status;