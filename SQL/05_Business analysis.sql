### MODULE 1 :SALE PERFORMANCE ANALYTICS

## TOTAL SALES

SELECT
ROUND(SUM(SALES),2)AS TOTAL_SALES
FROM ORDER_ITEMS;

## TOTAL ORDERS


SELECT COUNT(*)AS TOTAL_ORDERS
FROM ORDERS;

##AVERAGE ORDER VALUE 

SELECT 
ROUND(AVG(ORDER_ITEM_TOTAL),2) AS AVERAGE_ORDER_VALUE
FROM ORDERS_ITEMS;

SELECT * FROM ORDER_ITEMS;

## HEIGHEST SALES ORDER
SELECT
ORDER_ID,
ROUND(SUM(ORDER_ITEM_TOTAL),2)AS ORDER_VALUE
FROM ORDER_ITEMS
GROUP BY ORDER_ID
ORDER BY  ORDER_VALUE DESC
LIMIT 1;

### LOWEST SALES VALUE
SELECT
ORDER_ID,
ROUND(SUM(ORDER_ITEM_TOTAL),2)AS ORDER_VALUE
FROM ORDER_ITEMS
GROUP BY ORDER_ID
ORDER BY  ORDER_VALUE
LIMIT 1;

## Monthly SALES TREND

SELECT
      YEAR(order_date)as year,
      month(order_date)as month,
      round(sum(oi.sales),2)as total_sales
      
from orders o
join order_items oi
on o.order_id=oi.order_id
group by
       year, month 
       
order by
       year,
       month;
      
# sales by order status

select 
     order_status,
     round(sum(oi.sales),2) as total_sales
from orders o
join order_items oi
on o.order_id=oi.order_id
group by order_status
order by total_sales desc;

### top 10 order by sales
select 
     order_id,
     round(sum(sales),2) as total_sales
from order_items
group by order_id
order by total_sales desc
limit 10;

## module 2: customer analytics 
# total customers

select count(*) as total_customers
from customers;

## customer by segment

select
     customer_segment,
     count(*) as total_customers
from customers
group by customer_segment
order by total_customer desc;


### top 10 customers by sales 

select 
      c.customer_id,
      concat(c.customer_first_name,' ',c.customer_last_name)as customer_name,
      round (sum(oi.sales),2)as total_sales
from customers c
join orders o
on c.customer_id=o.customer_id
join order_items oi
on o.order_id=oi.order_id
group by 
      c.customer_id,
      customer_name
order by total_sales desc
limit 10;

## bottom 10 customer by sales 

select 
      c.customer_id,
      concat(c.customer_first_name,' ',c.customer_last_name)as customer_name,
      round (sum(oi.sales),2)as total_sales
from customers c
join orders o
on c.customer_id=o.customer_id
join order_items oi
on o.order_id=oi.order_id
group by 
      c.customer_id,
      customer_name
order by total_sales ASC
limit 10;

# AVERAGE CUSTOMER SPENDING

SELECT 
      ROUND (AVG(CUSTOMER_TOTAL_SALES),2) AS AVG_CUSTOMER_SPENDING
FROM
(
	SELECT c.customer_id,
    sum(oi.sales)as customer_total_sales
    from customers c
    join orders o
       on c.customer_id=o.customer_id
    join order_items oi
      on o.order_id=oi.order_id
   group by c.customer_id
   )as customersales;
   
   ### repeat customers 
   
select 
      customer_id,
      count(order_id) as total_orders
from orders 
group by customer_id
having count(order_id)>1
order by total_orders desc;

### top customer by number of orders 
select 
      customer_id,
      count(order_id) as total_orders
from orders 
group by customer_id
order by total_orders desc
limit 1;

 ## customer distribution by country
 
 
select
     customer_country,
     count(*) as total_customers
from customers
group by customer_country
order by total_customers desc;

##module 3: products analytis
## total products 
select count(*) as total_products
from products;

## product by category      -----
select  
	c.category_name,
    count(*) as total_products 
from products p
join categoriess c
on p.category_id=c.category_id
group by c.category_name
order by total_products desc;

##  product by department 

select  
	d.department_name,
    count(*) as total_products 
from products p
join departments d
on p.department_id= d.department_id
group by d.department_name
order by total_products desc;

## top 10 best selling products
 
 select 
      p.product_card_id,
      p.product_name,
      round(sum(oi.sales),2) as total_sales
from products p
join order_items oi
on p.product_card_id =oi.product_card_id 
group by 
      p.product_card_id,
      p.product_name
order by total_sales desc
limit 10;

### bottom 10 product by sales 

select 
      p.product_card_id,
      p.product_name,
      round(sum(oi.sales),2) as total_sales
from products p
join order_items oi
on p.product_card_id =oi.product_card_id 
group by 
      p.product_card_id,
      p.product_name
order by total_sales asc
limit 10;

## heighest revenue category      -------
select 
    c.category_name,
    round(sum(oi.sales),2)as revenue
from categoriess c
join products p 
on c.category_id=p.category_id
join order_items oi
on p.product_card_id=oi.product_card_id
group by c.category_name
order by revenue desc;

### heighest revenue department 
select 
     d.department_name,
     round(sum(oi.sales),2)as revenue
from departments d
join products p
on d.department_id=p.department_id
join order_items oi
on p.product_card_id=oi.product_card_id
group by d.department_name
order by revenue desc;

##  average product price by category
select 
    c.category_name,
    round(avg(p.product_price),2)as average_product_price
from categoriess c
join products p 
on c.category_id=p.category_id
group by c.category_name
order by average_product_price desc;

### module 4 orders analytics 
# total order by status 

select 
     order_status,
     count(*) as total_orders
from orders 
group by order_status 
order by total_orders desc;

## total order by shipping mode 
select 
     shipping_mode,
     count(*) as total_orders
from orders 
group by shipping_mode 
order by total_orders desc;

## monthly order trend 
SELECT
      YEAR(order_date)as order_year,
      month(order_date)as order_month,
      count(*) as total_orders
from orders 
group by
       year(order_date), 
       month (order_date)
order by
       order_year,
       order_month;

# Average Products per Order  --------
SELECT
    ROUND(AVG(Product_Count),2) AS Avg_Products_Per_Order
FROM
(
    SELECT
        Order_ID,
        COUNT(Product_Card_ID) AS Product_Count
    FROM Order_Items
    GROUP BY Order_ID
) AS OrderSummary;

# Top 10 Largest Orders (by Quantity)

SELECT
    Order_ID,
    SUM(Order_Item_Quantity) AS Total_Quantity
FROM Order_Items
GROUP BY Order_ID
ORDER BY Total_Quantity DESC
LIMIT 10;

# Orders with Highest Discount
SELECT
    Order_ID,
    ROUND(SUM(Order_Item_Discount),2) AS Total_Discount
FROM Order_Items
GROUP BY Order_ID
ORDER BY Total_Discount DESC
LIMIT 10;

## Module 5 : Shipping & Delivery Analytics
# Orders by Delivery Status
SELECT
    Delivery_Status,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Delivery_Status
ORDER BY Total_Orders DESC;

# Late Delivery Risk Distribution
SELECT
    Late_Delivery_Risk,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Late_Delivery_Risk;

# Late Delivery Percentage
SELECT
    ROUND(
        SUM(CASE WHEN Late_Delivery_Risk = 1 THEN 1 ELSE 0 END)
        *100.0/COUNT(*),2
    ) AS Late_Delivery_Percentage
FROM Orders;

# Average Actual Shipping Days
SELECT
    ROUND(AVG(Actual_Shipping_Days),2) AS Avg_Actual_Shipping_Days
FROM Orders;

# Average Scheduled Shipping Days
SELECT
    ROUND(AVG(Scheduled_Shipping_Days),2) AS Avg_Scheduled_Shipping_Days
FROM Orders;

# Shipping Delay Analysis
SELECT
    ROUND(
        AVG(Actual_Shipping_Days - Scheduled_Shipping_Days),2
    ) AS Avg_Delay_Days
FROM Orders;

# Shipping Mode Performance
SELECT
    Shipping_Mode,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(Actual_Shipping_Days),2) AS Avg_Shipping_Days
FROM Orders
GROUP BY Shipping_Mode
ORDER BY Total_Orders DESC;

# Delivery Status by Shipping Mode
SELECT
    Shipping_Mode,
    Delivery_Status,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY
    Shipping_Mode,
    Delivery_Status
ORDER BY
    Shipping_Mode,
    Total_Orders DESC;
    
## Module 6 : Profitability Analytics
# Total Profit
SELECT
    ROUND(SUM(Order_Profit_Per_Order),2) AS Total_Profit
FROM Order_Items;

# Average Profit Per Order
SELECT
    ROUND(AVG(Order_Profit),2) AS Avg_Profit_Per_Order
FROM
(
    SELECT
        Order_ID,
        SUM(Order_Profit_Per_Order) AS Order_Profit
    FROM Order_Items
    GROUP BY Order_ID
) AS ProfitSummary;

# Profit by Category
SELECT
    c.Category_Name,
    ROUND(SUM(oi.Order_Profit_Per_Order),2) AS Total_Profit
FROM Categoriess c
JOIN Products p
    ON c.Category_ID = p.Category_ID
JOIN Order_Items oi
    ON p.Product_Card_ID = oi.Product_Card_ID
GROUP BY c.Category_Name
ORDER BY Total_Profit DESC;

# Profit by Department
SELECT
    d.Department_Name,
    ROUND(SUM(oi.Order_Profit_Per_Order),2) AS Total_Profit
FROM Departments d
JOIN Products p
    ON d.Department_ID = p.Department_ID
JOIN Order_Items oi
    ON p.Product_Card_ID = oi.Product_Card_ID
GROUP BY d.Department_Name
ORDER BY Total_Profit DESC;

# Top 10 Most Profitable Products
SELECT
    p.Product_Card_ID,
    p.Product_Name,
    ROUND(SUM(oi.Order_Profit_Per_Order),2) AS Total_Profit
FROM Products p
JOIN Order_Items oi
    ON p.Product_Card_ID = oi.Product_Card_ID
GROUP BY
    p.Product_Card_ID,
    p.Product_Name
ORDER BY Total_Profit DESC
LIMIT 10;

# Bottom 10 Least Profitable Products
SELECT
    p.Product_Card_ID,
    p.Product_Name,
    ROUND(SUM(oi.Order_Profit_Per_Order),2) AS Total_Profit
FROM Products p
JOIN Order_Items oi
    ON p.Product_Card_ID = oi.Product_Card_ID
GROUP BY
    p.Product_Card_ID,
    p.Product_Name
ORDER BY Total_Profit ASC
LIMIT 10;

# Profit Margin by Product
SELECT
    p.Product_Name,
    ROUND(
        (SUM(oi.Order_Profit_Per_Order) / SUM(oi.Sales)) * 100,
        2
    ) AS Profit_Margin_Percentage
FROM Products p
JOIN Order_Items oi
    ON p.Product_Card_ID = oi.Product_Card_ID
GROUP BY p.Product_Name
HAVING SUM(oi.Sales) > 0
ORDER BY Profit_Margin_Percentage DESC;

# Loss-Making Orders
SELECT
    Order_ID,
    ROUND(SUM(Order_Profit_Per_Order),2) AS Total_Profit
FROM Order_Items
GROUP BY Order_ID
HAVING SUM(Order_Profit_Per_Order) < 0
ORDER BY Total_Profit;

## Module 7 : Geographic & Market Analytics

# Sales by Market
SELECT
    o.Market,
    ROUND(SUM(oi.Sales),2) AS Total_Sales
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID = oi.Order_ID
GROUP BY o.Market
ORDER BY Total_Sales DESC;

# Sales by Region
SELECT
    o.Order_Region,
    ROUND(SUM(oi.Sales),2) AS Total_Sales
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID = oi.Order_ID
GROUP BY o.Order_Region
ORDER BY Total_Sales DESC;

# Sales by Country
SELECT
    o.Order_Country,
    ROUND(SUM(oi.Sales),2) AS Total_Sales
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID = oi.Order_ID
GROUP BY o.Order_Country
ORDER BY Total_Sales DESC;

# Top 10 Cities by Sales
SELECT
    o.Order_City,
    ROUND(SUM(oi.Sales),2) AS Total_Sales
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID = oi.Order_ID
GROUP BY o.Order_City
ORDER BY Total_Sales DESC
LIMIT 10;

# Customers by Country
SELECT
    Customer_Country,
    COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Customer_Country
ORDER BY Total_Customers DESC;

# Customers by State
SELECT
    Customer_State,
    COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Customer_State
ORDER BY Total_Customers DESC;

# Orders by Market
SELECT
    Market,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Market
ORDER BY Total_Orders DESC;

# Average Sales by Region
SELECT
    o.Order_Region,
    ROUND(AVG(oi.Sales),2) AS Average_Sales
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID = oi.Order_ID
GROUP BY o.Order_Region
ORDER BY Average_Sales DESC;

## Module 8 : Advanced SQL Analytics
# Rank Products by Sales (RANK)
SELECT
    p.Product_Name,
    ROUND(SUM(oi.Sales),2) AS Total_Sales,
    RANK() OVER(
        ORDER BY SUM(oi.Sales) DESC
    ) AS Sales_Rank
FROM Products p
JOIN Order_Items oi
ON p.Product_Card_ID = oi.Product_Card_ID
GROUP BY
    p.Product_Card_ID,
    p.Product_Name;
    
# Dense Rank Products
SELECT
    p.Product_Name,
    ROUND(SUM(oi.Sales),2) AS Total_Sales,
    DENSE_RANK() OVER(
        ORDER BY SUM(oi.Sales) DESC
    ) AS Dens_Rank
FROM Products p
JOIN Order_Items oi
ON p.Product_Card_ID = oi.Product_Card_ID
GROUP BY
    p.Product_Card_ID,
    p.Product_Name;
    
    # Row Number for Orders
SELECT
    Order_ID,
    Order_Date,
    ROW_NUMBER() OVER(
        ORDER BY Order_Date
    ) AS Row_Num
FROM Orders;

# Running Sales Total
SELECT
    o.Order_Date,
    ROUND(SUM(oi.Sales),2) AS Daily_Sales,
    ROUND(
        SUM(SUM(oi.Sales))
        OVER(
            ORDER BY o.Order_Date
        ),2
    ) AS Running_Total
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID = oi.Order_ID
GROUP BY o.Order_Date
ORDER BY o.Order_Date;

# Previous Order Sales (LAG)
SELECT
    o.Order_Date,
    ROUND(SUM(oi.Sales),2) AS Daily_Sales,
    LAG(
        ROUND(SUM(oi.Sales),2)
    ) OVER(
        ORDER BY o.Order_Date
    ) AS Previous_Day_Sales
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID = oi.Order_ID
GROUP BY o.Order_Date
ORDER BY o.Order_Date;

# Next Order Sales (LEAD)
SELECT
    o.Order_Date,
    ROUND(SUM(oi.Sales),2) AS Daily_Sales,
    LEAD(
        ROUND(SUM(oi.Sales),2)
    ) OVER(
        ORDER BY o.Order_Date
    ) AS Next_Day_Sales
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID = oi.Order_ID
GROUP BY o.Order_Date
ORDER BY o.Order_Date;

# Top Product in Each Category (CTE + ROW_NUMBER)
WITH ProductSales AS
(
    SELECT
        c.Category_Name,
        p.Product_Name,
        ROUND(SUM(oi.Sales),2) AS Total_Sales,
        ROW_NUMBER() OVER(
            PARTITION BY c.Category_Name
            ORDER BY SUM(oi.Sales) DESC
        ) AS RN
    FROM Categoriess c
    JOIN Products p
        ON c.Category_ID = p.Category_ID
    JOIN Order_Items oi
        ON p.Product_Card_ID = oi.Product_Card_ID
    GROUP BY
        c.Category_Name,
        p.Product_Name
)
SELECT *
FROM ProductSales
WHERE RN = 1;

# Sales Contribution %
SELECT
    p.Product_Name,
    ROUND(SUM(oi.Sales),2) AS Total_Sales,
    ROUND(
        SUM(oi.Sales)
        *100/
        SUM(SUM(oi.Sales)) OVER(),
        2
    ) AS Contribution_Percentage
FROM Products p
JOIN Order_Items oi
ON p.Product_Card_ID = oi.Product_Card_ID
GROUP BY p.Product_Name
ORDER BY Total_Sales DESC;
