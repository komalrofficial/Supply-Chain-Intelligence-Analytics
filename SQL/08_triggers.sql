## Prevent Negative Quantity
DELIMITER $$

CREATE TRIGGER trg_Prevent_Negative_Quantity
BEFORE INSERT ON Order_Items
FOR EACH ROW
BEGIN
    IF NEW.Order_Item_Quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order quantity must be greater than zero.';
    END IF;
END$$

DELIMITER ;

INSERT INTO Order_Items
(
    Order_Item_ID,
    Order_ID,
    Product_Card_ID,
    Order_Item_Quantity,
    Order_Item_Product_Price,
    Order_Item_Discount,
    Order_Item_Discount_Rate,
    Order_Item_Total,
    Order_Item_Profit_Ratio,
    Benefit_Per_Order,
    Order_Profit_Per_Order,
    Sales,
    Sales_Per_Customer
)
VALUES
(
999999,
1001,
100,
-5,
100,
0,
0,
100,
0.20,
20,
20,
100,
100
);

## Prevent Future Order Dates
DELIMITER $$

CREATE TRIGGER trg_Prevent_Future_OrderDate
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    IF NEW.Order_Date > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Future order dates are not allowed.';
    END IF;
END$$

DELIMITER ;

## Prevent Negative Sales
DELIMITER $$

CREATE TRIGGER trg_Prevent_Negative_Sales
BEFORE INSERT ON Order_Items
FOR EACH ROW
BEGIN
    IF NEW.Sales < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Sales amount cannot be negative.';
    END IF;
END$$

DELIMITER ;

SHOW TRIGGERS;