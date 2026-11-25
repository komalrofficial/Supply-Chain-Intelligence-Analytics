## Sales Summary
CREATE VIEW vw_Sales_Summary AS
SELECT
    o.Order_ID,
    o.Order_Date,
    o.Order_Country,
    o.Order_Region,
    SUM(oi.Sales) AS Total_Sales,
    SUM(oi.Order_Profit_Per_Order) AS Total_Profit
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID = oi.Order_ID
GROUP BY
    o.Order_ID,
    o.Order_Date,
    o.Order_Country,
    o.Order_Region;
    
SELECT * FROM vw_Sales_Summary;

## Customer Sales
CREATE VIEW vw_Customer_Sales AS
SELECT
    c.Customer_ID,
    CONCAT(c.Customer_First_Name,' ',c.Customer_Last_Name) AS Customer_Name,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(oi.Sales) AS Total_Sales
FROM Customers c
JOIN Orders o
ON c.Customer_ID=o.Customer_ID
JOIN Order_Items oi
ON o.Order_ID=oi.Order_ID
GROUP BY
    c.Customer_ID,
    Customer_Name;
    
## Product Performance
CREATE VIEW vw_Product_Performance AS
SELECT
    p.Product_Name,
    SUM(oi.Sales) AS Total_Sales,
    SUM(oi.Order_Profit_Per_Order) AS Total_Profit,
    SUM(oi.Order_Item_Quantity) AS Quantity_Sold
FROM Products p
JOIN Order_Items oi
ON p.Product_Card_ID=oi.Product_Card_ID
GROUP BY p.Product_Name;

## Shipping Performance
CREATE VIEW vw_Shipping_Performance AS
SELECT
    Shipping_Mode,
    Delivery_Status,
    COUNT(*) AS Total_Orders,
    AVG(Actual_Shipping_Days) AS Avg_Shipping_Days
FROM Orders
GROUP BY
    Shipping_Mode,
    Delivery_Status;
    
## Market Performance
CREATE VIEW vw_Market_Performance AS
SELECT
    Market,
    Order_Region,
    SUM(oi.Sales) AS Total_Sales,
    SUM(oi.Order_Profit_Per_Order) AS Total_Profit
FROM Orders o
JOIN Order_Items oi
ON o.Order_ID=oi.Order_ID
GROUP BY
    Market,
    Order_Region;