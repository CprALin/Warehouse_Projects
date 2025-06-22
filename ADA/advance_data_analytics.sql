
SELECT 
	YEAR(order_date) AS order_year,	
	MONTH(order_date) AS order_month,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_id) AS total_customers,
	SUM(quntity) AS total_quantity 
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY  YEAR(order_date) , MONTH(order_date)
ORDER BY  YEAR(order_date) , MONTH(order_date)


SELECT 
	DATETRUNC(month , order_date) AS order_month,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_id) AS total_customers,
	SUM(quntity) AS total_quantity 
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY  DATETRUNC(month , order_date)
ORDER BY  DATETRUNC(month , order_date)

SELECT 
	FORMAT(order_date , 'yyyy-MMM') AS order_month,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_id) AS total_customers,
	SUM(quntity) AS total_quantity 
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY  FORMAT(order_date , 'yyyy-MMM')
ORDER BY  FORMAT(order_date , 'yyyy-MMM')

-- Calculate the total sales per month
-- and the running total of sales over time
SELECT 
	order_date,
	total_sales,
	SUM(total_sales) OVER (PARTITION BY order_date ORDER BY order_date) AS running_total_sales,
	AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
-- window function
FROM (
	SELECT 
		DATETRUNC(month , order_date) AS order_date,
		SUM(sales_amount) AS total_sales, 
		AVG(price) AS avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(month , order_date)
)t

/* Analyze the yearly performance of products by comparing their sales to both 
   the average sales performance of the product and the product and the previous 
   year's sales */
WITH yearly_product_sales AS (
SELECT 
	YEAR(f.order_date) AS order_year,
	p.product_name,
	SUM(f.sales_amount) AS current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_product p ON f.product_key = p.product_key
WHERE f.order_date IS NOT NULL
GROUP BY YEAR(f.order_date),
p.product_name
)

SELECT 
	order_year,
	product_name,
	current_sales,
	AVG(current_sales) OVER (PARTITION BY product_name) avg_sales,
	current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
	 WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
	 ELSE 'Avg'
END avg_change,
-- Year-over-year Analysis
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) py_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
	 WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
	 ELSE 'No Change'
END py_change
FROM yearly_product_sales
ORDER BY product_name , order_year


-- Which categories contribute the most to overall sales ? 
WITH category_sales AS (
SELECT 
	category,
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales f 
LEFT JOIN gold.dim_product p ON p.product_key = f.product_key
GROUP BY category
)
SELECT 
	category,
	total_sales,
	SUM(total_sales) OVER () overall_sales,
	CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100 , 2) , '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC
