
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
