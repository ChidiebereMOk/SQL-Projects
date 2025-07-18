USE house_sales;

-- Average house price by number of bedrooms
SELECT 
	bedrooms, CONCAT('$', ROUND(AVG(price), 2)) AS avg_price
FROM housedata
GROUP BY bedrooms
ORDER BY bedrooms;

-- Top 10 most expensive houses
SELECT
	id, CONCAT('$', price), bedrooms, bathrooms, sqft_living, zipcode
FROM housedata
ORDER BY price DESC
LIMIT 10;

-- Count of waterfront properties
SELECT
	waterfront, COUNT(*) AS property_count
FROM housedata
GROUP BY waterfront;

-- Average prie by condition
SELECT
	housedata.condition, CONCAT('$', ROUND(AVG(price),2)) AS avg_price
FROM housedata
GROUP BY housedata.condition
ORDER BY avg_price DESC;

-- Total number of houses built per decade
SELECT
	FLOOR(yr_built/10)*10 AS decade_built, COUNT(*) AS houses_built
GROUP BY decade_built
ORDER BY decade_built;

-- Average square footage of living area by number of floors
SELECT
	floors, ROUND(AVG(sqft_living),2) AS avg_sqft_living
FROM housedata
GROUP BY floors
ORDER BY floors;

-- Distribution of house grades
SELECT
	grade, COUNT(*) AS house_count
FROM housedata
GROUP BY grade
ORDER BY grade;

-- Zip codes with the highest average home price
SELECT
	zipcode, CONCAT( '$', ROUND(AVG(price),2)) AS avg_price
FROM housedata
GROUP BY zipcode
ORDER BY avg_price DESC
LIMIT 10;

-- Average price per square foot (living area)
SELECT
	CONCAT('$', ROUND(AVG(price/sqft_living),2)) AS avg_price_per_sqft
FROM housedata;

-- Monthly sales volume (number of homes sold per month)
SELECT
	DATE_FORMAT(date, '%Y-%m') AS month, COUNT(*) AS sales_volume
FROM housedata 
GROUP BY month;




