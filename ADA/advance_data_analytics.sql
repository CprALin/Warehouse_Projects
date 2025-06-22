
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
