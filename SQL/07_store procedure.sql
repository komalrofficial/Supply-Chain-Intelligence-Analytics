## sales by country 
use supplychainanalytics;
drop procedure sp_sales_by_country;

delimiter $$
create procedure sp_sales_by_country (
in p_country varchar(100)
)
begin 
    select o.order_country,
    Round(sum(oi.sales),2) as total_sales,
    Round(sum(oi.order_profit_per_order),2) as total_profit
    
from orders o
join order_items oi
        ON o.Order_ID = oi.Order_ID
    WHERE o.Order_Country = p_country
    GROUP BY o.Order_Country;
END $$

DELIMITER ;

CALL sp_Sales_by_Country('India');

## Customer Purchase Summary
DELIMITER $$

CREATE PROCEDURE sp_Customer_Summary(
    IN p_customer INT
)
BEGIN
    SELECT
        c.Customer_ID,
        CONCAT(c.Customer_First_Name,' ',c.Customer_Last_Name) AS Customer_Name,
        COUNT(DISTINCT o.Order_ID) AS Total_Orders,
        ROUND(SUM(oi.Sales),2) AS Total_Sales
    FROM Customers c
    JOIN Orders o
        ON c.Customer_ID = o.Customer_ID
    JOIN Order_Items oi
        ON o.Order_ID = oi.Order_ID
    WHERE c.Customer_ID = p_customer
    GROUP BY
        c.Customer_ID,
        Customer_Name;
END $$

DELIMITER ;
CALL sp_Customer_Summary(1001);

## Sales Between Two Dates
DELIMITER $$

CREATE PROCEDURE sp_Sales_By_Date(
    IN p_start DATE,
    IN p_end DATE
)
BEGIN
    SELECT
        o.Order_Date,
        ROUND(SUM(oi.Sales),2) AS Total_Sales
    FROM Orders o
    JOIN Order_Items oi
        ON o.Order_ID = oi.Order_ID
    WHERE o.Order_Date BETWEEN p_start AND p_end
    GROUP BY o.Order_Date
    ORDER BY o.Order_Date;
END $$

DELIMITER ;
CALL sp_Sales_By_Date('2018-01-01','2018-01-31');

## Top N Products
DELIMITER $$

CREATE PROCEDURE sp_Top_Products(
    IN p_limit INT
)
BEGIN
    SELECT
        p.Product_Name,
        ROUND(SUM(oi.Sales),2) AS Total_Sales
    FROM Products p
    JOIN Order_Items oi
        ON p.Product_Card_ID = oi.Product_Card_ID
    GROUP BY p.Product_Name
    ORDER BY Total_Sales DESC
    LIMIT p_limit;
END $$

DELIMITER ;
CALL sp_Top_Products(10);


SHOW PROCEDURE STATUS
WHERE Db = DATABASE();
