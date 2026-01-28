-- Global Superstore SQL Window Functions Project
--------------------------------------------------------------
-- STEP 1: Table creation
CREATE TABLE superstore (
    row_id INT,
    order_id TEXT,
    order_date TIMESTAMP,
    ship_date TIMESTAMP,
    ship_mode TEXT,
    customer_id TEXT,
    customer_name TEXT,
    segment TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    region TEXT,
    market TEXT,
    category TEXT,
    sub_category TEXT,
    product_id TEXT,
    product_name TEXT,
    sales NUMERIC,
    quantity INT,
    discount NUMERIC,
    profit NUMERIC,
    shipping_cost NUMERIC,
    year INT,
    weeknum INT
);

-- STEP 2: Total sales per customer
SELECT
    customer_id,
    customer_name,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC;

-- STEP 3: Rank customers by sales per region
SELECT
    region,
    customer_id,
    customer_name,
    SUM(sales) AS total_sales,
    ROW_NUMBER() OVER (
        PARTITION BY region
        ORDER BY SUM(sales) DESC
    ) AS region_rank
FROM superstore
GROUP BY region, customer_id, customer_name;

-- STEP 4: RANK vs DENSE_RANK comparison
SELECT
    region,
    customer_id,
    customer_name,
    SUM(sales) AS total_sales,
    RANK() OVER (
        PARTITION BY region
        ORDER BY SUM(sales) DESC
    ) AS rank_with_gaps,
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY SUM(sales) DESC
    ) AS dense_rank_no_gaps
FROM superstore
GROUP BY region, customer_id, customer_name;

-- STEP 5: Running total sales by date
SELECT
    order_date::date AS order_date,
    SUM(sales) AS daily_sales,
    SUM(SUM(sales)) OVER (
        ORDER BY order_date::date
    ) AS running_total_sales
FROM superstore
GROUP BY order_date::date
ORDER BY order_date::date;

-- STEP 6: Month-over-Month growth
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY month))
        / LAG(total_sales) OVER (ORDER BY month) * 100,
        2
    ) AS mom_growth_percentage
FROM monthly_sales;

-- STEP 7: Top 3 products per category
WITH product_sales AS (
    SELECT
        category,
        product_name,
        SUM(sales) AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY SUM(sales) DESC
        ) AS product_rank
    FROM superstore
    GROUP BY category, product_name
)
SELECT *
FROM product_sales
WHERE product_rank <= 3
ORDER BY category, product_rank;
