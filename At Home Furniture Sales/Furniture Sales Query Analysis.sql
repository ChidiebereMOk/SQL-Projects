USE furniture_sales;

-- Total Sales by Region
SELECT l.region, CONCAT('$', ROUND(SUM(o.sales),2)) AS total_sales
FROM orders o
JOIN location l
ON o.postal_code = l.postal_code
GROUP BY l.region
ORDER BY total_sales DESC;

-- Top 5 Selling Products by Revenue
SELECT 
	p.product_name, CONCAT('$', ROUND(SUM(o.sales),2)) AS revenue
FROM orders o
JOIN products p 
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;

-- Average Profit by Category
SELECT
	p.category, CONCAT('$', ROUND(AVG(o.profit),2)) AS avg_profit
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category;

-- Top 10 Customers
SELECT
	c.customer_name, CONCAT('$', ROUND(SUM(o.sales),2)) AS total_spent
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- Repeat Customers
SELECT
	customer_id, COUNT(DISTINCT order_id) AS number_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) > 1
ORDER BY number_orders DESC;

-- Sales and Profit by Customer by Customer Segment
SELECT
	segment, CONCAT('$',ROUND(SUM(sales),2)) AS total_sales, CONCAT('$',ROUND(SUM(profit),2)) AS total_profit
FROM orders
GROUP BY segment;

-- Most Frequently Ordered Sub-Category
SELECT
	p.sub_category, COUNT(*) AS number_orders
FROM orders o
JOIN products p 
ON o.product_id = p.product_id
GROUP BY p.sub_category
ORDER BY number_orders DESC
LIMIT 1;

-- Sales per Product
SELECT
	p.product_name, SUM(o.Quantity) AS total_units, CONCAT('$',ROUND(SUM(o.sales),2)) AS total_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;

-- Average Discount by Category
SELECT
	p.category, CONCAT(ROUND(AVG(o.discount),2)*100, '%') AS avg_discount
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

-- Monthly Sales Trend (Note: All Dates are in EU Format)
SELECT 
  DATE_FORMAT(STR_TO_DATE(order_date, '%d/%m/%Y'), '%Y-%m') AS YearMonth, CONCAT('$', ROUND(SUM(sales),2)) AS monthly_sales
FROM orders
GROUP BY YearMonth
ORDER BY YearMonth;


-- Shipping Delay (in Days)
SELECT 
  DATEDIFF(DATE_FORMAT(STR_TO_DATE(ship_date, '%d/%m/%Y'), '%Y-%m-%d'),DATE_FORMAT(STR_TO_DATE(Order_Date, '%d/%m/%Y'), '%Y-%m-%d')) 
  AS shipping_days
FROM orders
ORDER BY shipping_days DESC;

-- Top Sales Months
SELECT
	DATE_FORMAT(STR_TO_DATE(order_date, '%d/%m/%y'), '%Y-%m') AS YearMonth, 
    CONCAT('$',ROUND(SUM(sales),2)) AS total_sales
FROM orders
GROUP BY YearMonth
ORDER BY total_sales DESC;

-- Products with the Highest Profit Margin
SELECT
	p.product_name, 
    CONCAT(ROUND(SUM(o.profit)/NULLIF(sum(o.sales),0)*100,2),'%') as profit_margin
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY profit_margin DESC;

-- Regions with Highest Average Order Value
SELECT
	l.region, CONCAT('$',ROUND(AVG(o.sales),2)) as avg_order_value
FROM orders o
JOIN location l 
ON o.postal_code = l.postal_code
GROUP BY l.region
ORDER BY avg_order_value DESC;

-- Cumulative Sales Over Time  
SELECT 
  Order_Date,
  CONCAT('$', FORMAT(ROUND(SUM(sales) OVER (ORDER BY STR_TO_DATE(Order_Date, '%d/%m/%Y') ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2), 2)) AS Cumulative_Sales
FROM orders
ORDER BY STR_TO_DATE(Order_Date, '%d/%m/%Y');


