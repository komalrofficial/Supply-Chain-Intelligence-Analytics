### CUSTOMERS TABLE
CREATE TABLE Customers(
      customer_id int primary key,
      customer_first_name varchar(50),
      customer_last_name varchar(50),
      customer_segment varchar(30),
      customer_city varchar(100),
      customer_state varchar(100),
      customer_country varchar(100),
      customer_zip_code varchar(20),
      customer_street varchar(255),
      latitude decimal(10,2),
      longitude decimal(10,2)
      );
	
INSERT INTO Customers
SELECT distinct
	  customer_id,
      customer_first_name,
      customer_last_name, 
      customer_segment,
      customer_city,
      customer_state,
      customer_country,
      customer_zip_code,
      customer_street ,
      latitude,
      longitude
FROM stg_supply_chain;


##CATEGORIES TABLE

CREATE TABLE Categoriess(
     category_id int primary key,
     category_name varchar(100)
     );

INSERT INTO Categoriess
SELECT DISTINCT
	 category_id,
     category_name
     FROM stg_supply_chain;
     
     
###DEPARTMENT TABLE

CREATE TABLE Departments(
       department_id int primary key,
       department_name varchar(100)
       );

INSERT INTO Departments
SELECT DISTINCT
       department_id,
       department_name
       FROM stg_supply_chain;
       
## PRODUCTS TABLE
CREATE TABLE Products
       (product_card_id int primary key,
        product_name varchar(255),
        product_price decimal(10,2),
		category_id int,
        department_id int);

INSERT INTO Products
SELECT distinct
        product_card_id,
        product_name ,
        product_price,
        category_id,
		department_id
	from stg_supply_chain;
    
    
#### ORDERS TABLE

CREATE TABLE Orders(
        order_id int primary key,
        customer_id int,
        order_date datetime,
        order_status varchar(50),
        order_city varchar(100),
        order_state varchar(100),
        order_country varchar(100),
        order_region varchar(100),
        market varchar(100),
        shipping_mode varchar(50),
        delivery_status varchar(50),
		actual_shipping_days int,
        scheduled_shipping_days int,
        late_delivery_risk boolean
        );
        
	INSERT INTO Orders
    SELECT distinct
        order_id,
        customer_id,
        str_to_date(order_date,'%d-%m-%y %h:%i'),
        order_status,
        order_city,
        order_state,
        order_country,
        order_region,
        market,
        shipping_mode,
        delivery_status ,
		actual_shipping_days,
        scheduled_shipping_days,
        late_delivery_risk
        FROM stg_supply_chain
        ;