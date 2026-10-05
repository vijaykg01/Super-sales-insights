create table super_store(
Row_ID	INT ,
Order_ID VARCHAR(50),	
Order_Date	DATE,
Ship_Date	DATE,
Ship_Mode VARCHAR(50),
Customer_ID	VARCHAR(50),
Customer_Name VARCHAR(50),
Segment VARCHAR(50),
Country	VARCHAR(50),
City VARCHAR(50),
State VARCHAR(50),
Postal_Code	INT,
Region VARCHAR(50),
Product_ID VARCHAR(50),
Category VARCHAR(50),
Sub_Category VARCHAR(50),
Product_Name VARCHAR(100),	
Sales FLOAT);

-- IMPORT DATA FROM FILE
SELECT * FROM super_store;

-- NO OF CUSTOMERS
SELECT COUNT(*) FROM super_store;

-- ANY BLANK VALUE
SELECT * FROM super_store
WHERE order_id IS NULL;


-- TOTAL SALES
SELECT SUM(sales) as Total_sales
FROM super_store;


-- SALES BY SHIP MODE
SELECT ship_mode,
	SUM(sales) as Total_Sales
FROM super_store
GROUP BY ship_mode;


-- SALES BY SEGMENT
SELECT segment,
	SUM(sales) as Total_Sales
FROM super_store
GROUP BY segment;


-- SALES BY CATEGORY
SELECT category,
	SUM(sales) as Total_Sales
FROM super_store
GROUP BY category;


-- SALES BY REGION
SELECT region,
	SUM(sales) as Total_Sales
FROM super_store
GROUP BY region;


-- TOP 5 STATES BY SALES
SELECT state,
	SUM(sales) as total_sales
FROM super_store
GROUP BY state
ORDER BY 2 DESC
LIMIT 5;


-- TOP 10 CUSTOMERS BY SALES
SELECT
    customer_name,
    SUM(sales) AS total_sales
FROM super_store
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;


-- TOP 10 PRODUCTS BY SALES
SELECT
    product_name,
    SUM(sales) AS total_sales
FROM super_store
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;


-- MONTHLY SALES BY YEAR
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
	EXTRACT(MONTH FROM order_date) AS month,
    SUM(sales) AS total_sales
FROM super_store
GROUP BY
    EXTRACT(YEAR FROM order_date),
	EXTRACT(MONTH FROM order_date)
ORDER BY year, month;


-- YEARLY SALES
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(sales) AS total_sales
FROM super_store
GROUP BY
    EXTRACT(YEAR FROM order_date)
ORDER BY year;


-- YEAR-OVER-YEAR SALES GROWTH
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(sales) AS total_sales,
    LAG(SUM(sales)) OVER (ORDER BY EXTRACT(YEAR FROM order_date)) AS previous_year_sales,
   ROUND(
        (SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY EXTRACT(YEAR FROM order_date)))
        / LAG(SUM(sales)) OVER (ORDER BY EXTRACT(YEAR FROM order_date)) * 100,
        2
    ) AS yoy_growth_percentage
FROM super_store
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;







