-- ═══════════════════════════════════════════════════════════
-- E-Commerce Sales Performance Analysis
-- Author: Ashutosh
-- Tool: MySQL Workbench
-- Dataset: 5,500 rows | Indian E-Commerce | 2023-2024
-- ═══════════════════════════════════════════════════════════


-- ───────────────────────────────────────
-- STEP 1: Database Setup
-- ───────────────────────────────────────

CREATE DATABASE IF NOT EXISTS ecommerce_project;
USE ecommerce_project;


-- ───────────────────────────────────────
-- STEP 2: Create Table
-- ───────────────────────────────────────

CREATE TABLE sales_data (
    order_id VARCHAR(20),
    order_date DATE,
    delivery_date DATE,
    month VARCHAR(15),
    quarter VARCHAR(10),
    year INT,
    customer_id VARCHAR(15),
    customer_segment VARCHAR(20),
    platform VARCHAR(20),
    category VARCHAR(30),
    product_name VARCHAR(50),
    unit_price DECIMAL(10,2),
    quantity INT,
    discount_pct INT,
    discount_amount DECIMAL(10,2),
    gross_sales DECIMAL(10,2),
    net_sales DECIMAL(10,2),
    shipping_cost DECIMAL(10,2),
    tax_rate INT,
    tax_amount DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    profit DECIMAL(10,2),
    region VARCHAR(20),
    city VARCHAR(30),
    payment_method VARCHAR(20),
    shipping_method VARCHAR(20),
    order_status VARCHAR(20),
    customer_rating INT,
    return_reason VARCHAR(30),
    delivery_days INT
);


-- ───────────────────────────────────────
-- STEP 3: Fix Data Types
-- ───────────────────────────────────────

ALTER TABLE sales_data
MODIFY COLUMN order_date DATE,
MODIFY COLUMN delivery_date DATE,
MODIFY COLUMN year INT,
MODIFY COLUMN quantity INT,
MODIFY COLUMN discount_pct INT,
MODIFY COLUMN tax_rate INT,
MODIFY COLUMN customer_rating INT,
MODIFY COLUMN unit_price DOUBLE,
MODIFY COLUMN discount_amount DOUBLE,
MODIFY COLUMN gross_sales DOUBLE,
MODIFY COLUMN net_sales DOUBLE,
MODIFY COLUMN shipping_cost DOUBLE,
MODIFY COLUMN tax_amount DOUBLE,
MODIFY COLUMN total_amount DOUBLE,
MODIFY COLUMN profit DOUBLE,
MODIFY COLUMN delivery_days INT;


-- ───────────────────────────────────────
-- STEP 4: Data Validation
-- ───────────────────────────────────────

-- Check total row count
SELECT COUNT(*) AS total_rows FROM sales_data;

-- Preview first 5 rows
SELECT * FROM sales_data LIMIT 5;

-- Check all column names and data types
SHOW COLUMNS FROM sales_data;

-- Check for NULLs in critical columns
SELECT 
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN total_amount IS NULL THEN 1 ELSE 0 END) AS null_total_amount,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS null_profit
FROM sales_data;

-- Check distinct order statuses
SELECT 
    order_status, 
    COUNT(*) AS count 
FROM sales_data 
GROUP BY order_status;


-- ═══════════════════════════════════════════════════════════
-- STEP 5: Analysis Queries
-- ═══════════════════════════════════════════════════════════


-- Query 1: Total Revenue, Profit & Orders
-- Business Question: What is the overall sales performance?
-- ───────────────────────────────────────
SELECT 
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(total_amount)) * 100, 2) AS profit_margin_pct
FROM sales_data
WHERE order_status = 'Delivered';


-- Query 2: Revenue by Category
-- Business Question: Which product category drives the most revenue?
-- ───────────────────────────────────────
SELECT 
    category,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM sales_data
WHERE order_status = 'Delivered'
GROUP BY category
ORDER BY total_revenue DESC;


-- Query 3: Revenue by Platform
-- Business Question: Which platform generates the most sales?
-- ───────────────────────────────────────
SELECT 
    platform,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM sales_data
WHERE order_status = 'Delivered'
GROUP BY platform
ORDER BY total_revenue DESC;


-- Query 4: Monthly Revenue Trend
-- Business Question: How does revenue trend across months?
-- ───────────────────────────────────────
SELECT 
    month,
    year,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS monthly_revenue
FROM sales_data
WHERE order_status = 'Delivered'
GROUP BY year, month
ORDER BY year, STR_TO_DATE(month, '%b-%Y');


-- Query 5: Top 5 Cities by Revenue
-- Business Question: Which cities are the top revenue contributors?
-- ───────────────────────────────────────
SELECT 
    city,
    region,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM sales_data
WHERE order_status = 'Delivered'
GROUP BY city, region
ORDER BY total_revenue DESC
LIMIT 5;


-- Query 6: Return Rate by Category
-- Business Question: Which categories have the highest return rates?
-- ───────────────────────────────────────
SELECT 
    category,
    COUNT(order_id) AS total_orders,
    SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS return_rate_pct
FROM sales_data
GROUP BY category
ORDER BY return_rate_pct DESC;


-- Query 7: Customer Segment Performance
-- Business Question: Which customer segment is most valuable?
-- ───────────────────────────────────────
SELECT 
    customer_segment,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_data
WHERE order_status = 'Delivered'
GROUP BY customer_segment
ORDER BY total_revenue DESC;


-- Query 8: Top 5 Most Profitable Products
-- Business Question: Which products generate the most profit?
-- ───────────────────────────────────────
SELECT 
    product_name,
    category,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(customer_rating), 2) AS avg_rating
FROM sales_data
WHERE order_status = 'Delivered'
GROUP BY product_name, category
ORDER BY total_profit DESC
LIMIT 5;


-- Query 9: Running Total Revenue by Month (Window Function)
-- Business Question: What is the cumulative revenue growth per year?
-- ───────────────────────────────────────
SELECT 
    month,
    year,
    ROUND(SUM(total_amount), 2) AS monthly_revenue,
    ROUND(SUM(SUM(total_amount)) OVER (
        PARTITION BY year 
        ORDER BY STR_TO_DATE(month, '%b-%Y')
    ), 2) AS running_total
FROM sales_data
WHERE order_status = 'Delivered'
GROUP BY year, month
ORDER BY year, STR_TO_DATE(month, '%b-%Y');


-- Query 10: Payment Method vs Average Order Value
-- Business Question: Which payment method has the highest order value?
-- ───────────────────────────────────────
SELECT 
    payment_method,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(discount_pct), 2) AS avg_discount_pct
FROM sales_data
WHERE order_status = 'Delivered'
GROUP BY payment_method
ORDER BY avg_order_value DESC;


-- Query 11: Categories Above Average Return Rate (CTE + CROSS JOIN)
-- Business Question: Which categories have a higher than average return rate?
-- ───────────────────────────────────────
WITH category_return_rate AS (
    SELECT 
        category,
        COUNT(order_id) AS total_orders,
        SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
        ROUND(SUM(CASE WHEN order_status = 'Returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS return_rate_pct
    FROM sales_data
    GROUP BY category
),
overall_avg AS (
    SELECT ROUND(AVG(return_rate_pct), 2) AS avg_return_rate
    FROM category_return_rate
)
SELECT 
    c.category,
    c.total_orders,
    c.returned_orders,
    c.return_rate_pct,
    o.avg_return_rate,
    ROUND(c.return_rate_pct - o.avg_return_rate, 2) AS above_avg_by
FROM category_return_rate c
CROSS JOIN overall_avg o
WHERE c.return_rate_pct > o.avg_return_rate
ORDER BY c.return_rate_pct DESC;


-- Query 12: Top Performing City per Region (CTE + INNER JOIN)
-- Business Question: Which city leads revenue in each region?
-- ───────────────────────────────────────
WITH city_revenue AS (
    SELECT 
        city,
        region,
        ROUND(SUM(total_amount), 2) AS total_revenue,
        COUNT(order_id) AS total_orders
    FROM sales_data
    WHERE order_status = 'Delivered'
    GROUP BY city, region
),
region_max AS (
    SELECT 
        region,
        MAX(total_revenue) AS max_revenue
    FROM city_revenue
    GROUP BY region
)
SELECT 
    c.region,
    c.city,
    c.total_orders,
    c.total_revenue
FROM city_revenue c
INNER JOIN region_max r
    ON c.region = r.region 
    AND c.total_revenue = r.max_revenue
ORDER BY c.total_revenue DESC;


-- ═══════════════════════════════════════════════════════════
-- End of Analysis
-- ═══════════════════════════════════════════════════════════
