-- Explore All objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore all columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'

-- Explore All Countries our customers come from 
SELECT DISTINCT country FROM gold.dim_customers

-- Explore All Categories "The Major Divisions"
SELECT DISTINCT category FROM gold.dim_product

SELECT DISTINCT category , subcategory , product_name FROM gold.dim_product
ORDER BY 1,2,3

-- Find the date of the first and last order
SELECT 
MIN(order_date) AS first_order_date ,
MAX(order_date) AS last_order_date ,
DATEDIFF(year , MIN(order_date) , MAX(order_date)) AS order_range_year,
DATEDIFF(month , MIN(order_date) , MAX(order_date)) AS order_range_month
FROM gold.fact_sales

-- Find the youngest and the oldest customer 
SELECT 
MIN(birthdate) AS oldest_birthdate,
DATEDIFF(year, MIN(birthdate) , GETDATE()) AS oldest_age,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(year , MAX(birthdate) , GETDATE()) AS youngest_age
FROM gold.dim_customers


-- Find the Total Sales 
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales

-- Find how many items are sold 
SELECT  SUM(quntity) AS total_quantity FROM gold.fact_sales 

-- Find the avarage selling price 
SELECT AVG(price) AS avg_price FROM gold.fact_sales

-- Find the total number of orders 
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales 
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales

-- Find the total number of products 
SELECT COUNT(product_key) AS total_products FROM gold.dim_product

-- Find the total number of customers 
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers

-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customer FROM gold.dim_customers

-- Generate a report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_value, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' AS measure_name, SUM(quntity) AS measure_value FROM gold.fact_sales
