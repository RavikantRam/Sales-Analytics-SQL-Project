-- Create staging table to store raw CSV data (all columns as TEXT to avoid import errors)
CREATE TABLE sales_raw (
    row_id TEXT,
    order_id TEXT,
    order_date TEXT,
    ship_date TEXT,
    ship_mode TEXT,
    customer_id TEXT,
    customer_name TEXT,
    segment TEXT,
    country TEXT,
    city TEXT,
    state TEXT,
    postal_code TEXT,
    region TEXT,
    product_id TEXT,
    category TEXT,
    sub_category TEXT,
    product_name TEXT,
    sales TEXT,
    quantity TEXT,
    discount TEXT,
    profit TEXT
)

-- Check number of rows loaded in staging table
SELECT COUNT(*) FROM sales_raw;

-- Create final cleaned table with proper data types
CREATE TABLE sales (
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales NUMERIC(10,2),
    quantity INT,
    discount NUMERIC(5,2),
    profit NUMERIC(10,2)
);

-- Insert cleaned and converted data from staging table to final table
INSERT INTO sales
SELECT
    order_id,
    TO_DATE(order_date, 'MM/DD/YYYY'),    -- Convert text to DATE
    TO_DATE(ship_date, 'MM/DD/YYYY'),     -- Convert text to DATE
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales::NUMERIC,   -- Convert text to numeric
    quantity::INT,    -- Convert text to numeric
    discount::NUMERIC,-- Convert text to numeric  
    profit::NUMERIC   -- Convert text to numeric
FROM sales_raw;

-- Verify row count in cleaned table
SELECT COUNT(*) FROM sales;

-- View all records from final table
select * from sales;

-- Calculate overall total sales, profit and number of orders
SELECT 
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales;

-- Calculate average profit value
SELECT 
    AVG(profit) AS avg_profit_per_order
FROM sales;

-- Find highest and lowest sales values
SELECT 
    MAX(sales) AS highest_sale,
    MIN(sales) AS lowest_sale
FROM sales;

-- Calculate average discount given in each category
SELECT 
    category,
    AVG(discount) AS avg_discount
FROM sales
GROUP BY category;

-- Calculate total quantity sold in each region
SELECT 
    region,
    SUM(quantity) AS total_quantity
FROM sales
GROUP BY region;

-- Profit analysis for each category
SELECT 
    category,
    SUM(profit) AS total_profit,
    AVG(profit) AS avg_profit,
    MAX(profit) AS max_profit,
    MIN(profit) AS min_profit
FROM sales
GROUP BY category;


-- Count number of customers in each segment
SELECT 
    segment,
    COUNT(DISTINCT customer_id) AS customer_count
FROM sales
GROUP BY segment;

-- Calculate average purchase value for each customer
SELECT 
    customer_name,
    AVG(sales) AS avg_purchase_value
FROM sales
GROUP BY customer_name
ORDER BY avg_purchase_value DESC;

-- Calculate total sales by region
SELECT region, SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- Find top 10 most profitable products
SELECT product_name, SUM(profit) AS total_profit
FROM sales
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- Calculate total sales for each product category
SELECT category, SUM(sales) AS total_sales
FROM sales
GROUP BY category;

-- Monthly sales trend analysis
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(sales) AS monthly_sales
FROM sales
GROUP BY month
ORDER BY month;

-- Find top 10 customers by total spending
SELECT customer_name, SUM(sales) AS total_spent
FROM sales
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- Create index to improve search performance on order date
CREATE INDEX idx_sales_order_date ON sales(order_date);

-- Create index to speed up region based filtering
CREATE INDEX idx_sales_region ON sales(region);

-- Create index to improve product search performance
CREATE INDEX idx_sales_product ON sales(product_name);

-- Retrieve records for specific product (testing index performance)
SELECT * FROM sales
WHERE product_name = 'Luxo Economy Swing Arm Lamp';













