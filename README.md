# Supply Chain Analytics

A MySQL-based data analysis project focused on understanding supply
chain operations through sales, customer, product, order, shipping,
profitability, and geographic analysis. The project transforms staging
data into relational tables and uses SQL to generate business insights.

> **Current implementation:** MySQL and SQL\
> **Planned enhancement:** Microsoft Power BI dashboards

## Table of Contents

-   [Project Overview](#project-overview)
-   [Project Objectives](#project-objectives)
-   [Technology Stack](#technology-stack)
-   [Data Model](#data-model)
-   [Analysis Modules](#analysis-modules)
-   [SQL Concepts Used](#sql-concepts-used)
-   [Database Objects](#database-objects)
-   [Project Files](#project-files)
-   [Setup and Execution](#setup-and-execution)
-   [Future Enhancements](#future-enhancements)

## Project Overview

The project uses a staging table named `stg_supply_chain` as the source
for creating structured tables. The normalization script creates
customer, category, department, product, and order tables. The business
analysis script uses these tables together with an `Order_Items` table
to calculate operational and financial metrics.

The goal is to support data-driven understanding of supply chain
performance, including what is selling, which customers and markets
contribute sales, how products perform, and how shipping and delivery
operations are progressing.

## Project Objectives

-   Organize supply chain data into relational database tables.
-   Establish relationships between customers, orders, products,
    categories, and departments.
-   Analyze sales, order volume, customer purchasing behavior, and
    product performance.
-   Evaluate shipping duration, delivery status, and late-delivery risk.
-   Analyze profit, profit margin, and loss-making orders.
-   Compare performance across markets, regions, countries, and cities.
-   Prepare reusable SQL views and stored procedures for reporting.

## Technology Stack

  -----------------------------------------------------------------------
  Technology                          Purpose
  ----------------------------------- -----------------------------------
  MySQL                               Relational database management

  SQL                                 Data transformation, querying, and
                                      analysis

  MySQL Workbench                     Database development and query
                                      execution

  Microsoft Power BI                  Planned future dashboard and
                                      visualization layer
  -----------------------------------------------------------------------

## Data Model

The supplied normalization script creates the following five tables:

  -----------------------------------------------------------------------
  Table                               Purpose
  ----------------------------------- -----------------------------------
  `Customers`                         Customer names, segments, location,
                                      and geographic coordinates

  `Categoriess`                       Product category identifiers and
                                      names

  `Departments`                       Department identifiers and names

  `Products`                          Product names, prices, category,
                                      and department references

  `Orders`                            Order dates, customer references,
                                      order location, market, shipping
                                      mode, delivery status, and
                                      shipping-day details
  -----------------------------------------------------------------------

The analysis, views, stored procedures, and triggers also reference an
`Order_Items` table. This table contains order-line information such as
product, quantity, sales, discount, and profit measures.

### Relationships defined in the constraints script

-   `Products.category_id` → `Categoriess.category_id`
-   `Products.department_id` → `Departments.department_id`
-   `Orders.customer_id` → `Customers.customer_id`

The normalization script declares primary keys on the five tables it
creates.

## Analysis Modules

The business analysis script is organized into eight modules.

### 1. Sales Performance Analytics

-   Total sales and total orders
-   Average order value
-   Highest- and lowest-value orders
-   Monthly sales trends
-   Sales by order status
-   Top 10 orders by sales

### 2. Customer Analytics

-   Total customers and customer segments
-   Top 10 and bottom 10 customers by sales
-   Average customer spending
-   Repeat customers
-   Customers with the highest order count
-   Customer distribution by country

### 3. Product Analytics

-   Total products
-   Products by category and department
-   Top 10 and bottom 10 products by sales
-   Revenue by category and department
-   Average product price by category

### 4. Order Analytics

-   Orders by status and shipping mode
-   Monthly order trends
-   Average products per order
-   Largest orders by quantity
-   Orders with the highest discounts

### 5. Shipping & Delivery Analytics

-   Orders by delivery status
-   Late-delivery risk distribution and percentage
-   Average actual and scheduled shipping days
-   Average shipping delay
-   Shipping-mode performance
-   Delivery status by shipping mode

### 6. Profitability Analytics

-   Total and average profit
-   Profit by category and department
-   Most and least profitable products
-   Product profit margin
-   Loss-making orders

### 7. Geographic & Market Analytics

-   Sales by market, region, and country
-   Top 10 cities by sales
-   Customers by country and state
-   Orders by market
-   Average sales by region

### 8. Advanced SQL Analytics

-   Product ranking using `RANK()` and `DENSE_RANK()`
-   Order sequencing using `ROW_NUMBER()`
-   Running sales totals
-   Previous and next period sales using `LAG()` and `LEAD()`
-   Top product in each category using a CTE and `ROW_NUMBER()`
-   Product sales contribution percentage

## SQL Concepts Used

-   Database creation and selection
-   Staging data and table normalization
-   Primary keys and foreign key constraints
-   `INNER JOIN` and aggregate analysis
-   `GROUP BY`, `HAVING`, `ORDER BY`, and `LIMIT`
-   Aggregate functions: `SUM()`, `AVG()`, and `COUNT()`
-   Subqueries and Common Table Expressions (CTEs)
-   Window functions: `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `LAG()`,
    and `LEAD()`
-   Date functions: `YEAR()`, `MONTH()`, and `CURDATE()`
-   Views
-   Stored procedures with input parameters
-   Triggers and validation using `SIGNAL`

## Database Objects

### Views

The views script defines five reusable views:

  -----------------------------------------------------------------------
  View                                Purpose
  ----------------------------------- -----------------------------------
  `vw_Sales_Summary`                  Order-level sales and profit
                                      summary

  `vw_Customer_Sales`                 Customer order counts and sales

  `vw_Product_Performance`            Product sales, profit, and quantity
                                      sold

  `vw_Shipping_Performance`           Order counts and average shipping
                                      days by shipping mode and delivery
                                      status

  `vw_Market_Performance`             Sales and profit by market and
                                      region
  -----------------------------------------------------------------------

### Stored Procedures

The stored procedure script defines four procedures:

  -----------------------------------------------------------------------
  Procedure               Input                   Purpose
  ----------------------- ----------------------- -----------------------
  `sp_sales_by_country`   Country                 Calculates sales and
                                                  profit for a selected
                                                  country

  `sp_Customer_Summary`   Customer ID             Summarizes a customer's
                                                  orders and sales

  `sp_Sales_By_Date`      Start date, end date    Retrieves sales over a
                                                  selected date range

  `sp_Top_Products`       Result limit            Returns the top
                                                  products by sales
  -----------------------------------------------------------------------

### Triggers

The trigger script defines three validation triggers:

  ---------------------------------------------------------------------------------
  Trigger                           Event                   Validation
  --------------------------------- ----------------------- -----------------------
  `trg_Prevent_Negative_Quantity`   Before insert on        Rejects quantities less
                                    `Order_Items`           than or equal to zero

  `trg_Prevent_Future_OrderDate`    Before insert on        Rejects future order
                                    `Orders`                dates

  `trg_Prevent_Negative_Sales`      Before insert on        Rejects negative sales
                                    `Order_Items`           amounts
  ---------------------------------------------------------------------------------

## Project Files

  -----------------------------------------------------------------------
  File                                Description
  ----------------------------------- -----------------------------------
  `01_Create_database(1).sql`         Creates and selects the
                                      `supplychainanalytics` database;
                                      checks the staging table

  `02_Normalization.sql`              Creates and populates Customers,
                                      Categoriess, Departments, Products,
                                      and Orders from staging data

  `03-CONSTRAINTS.sql`                Adds foreign key relationships

  `05_Business analysis.sql`          Contains the eight business
                                      analysis modules

  `06_views.sql`                      Creates five analytical views

  `07_store procedure.sql`            Creates four parameterized stored
                                      procedures

  `08_triggers.sql`                   Creates three data validation
                                      triggers
  -----------------------------------------------------------------------

## Setup and Execution

1.  Install MySQL Server and open MySQL Workbench.
2.  Connect to your MySQL server.
3.  Load the source dataset into a staging table named
    `stg_supply_chain`.
4.  Run `01_Create_database(1).sql` to create and select the
    `supplychainanalytics` database.
5.  Run `02_Normalization.sql` to create and populate the normalized
    tables.
6.  Ensure the `Order_Items` table is also created and populated.
7.  Run `03-CONSTRAINTS.sql` to add the foreign key relationships.
8.  Run `05_Business analysis.sql` to execute the analysis queries.
9.  Run `06_views.sql` to create the analytical views.
10. Run `07_store procedure.sql` to create and test the stored
    procedures.
11. Run `08_triggers.sql` to create and test the validation triggers.

> **Important setup note:** The uploaded `01_Create_database(1).sql`
> script creates the database and queries `stg_supply_chain`; it does
> not create or import that staging table. The uploaded
> `02_Normalization.sql` creates five tables but does not create
> `Order_Items`, although the analysis, views, procedures, and triggers
> depend on it. Make sure the staging table and `Order_Items` table are
> available before executing the dependent scripts. The supplied file
> sequence also has no `04` script.

## Future Enhancements

-   Connect the MySQL database to Microsoft Power BI.
-   Build an executive supply chain overview dashboard.
-   Visualize sales, revenue, profit, and order trends.
-   Create customer and product performance reports.
-   Monitor shipping performance, delivery delays, and late-delivery
    risk.
-   Develop geographic and market performance dashboards.

## Learning Outcomes

This project provides practical experience in relational database
design, normalization, SQL-based business analysis, analytical views,
stored procedures, triggers, and advanced SQL window functions. It also
establishes a foundation for future business intelligence reporting with
Power BI.

------------------------------------------------------------------------

**Project:** Supply Chain Analytics\
**Database:** `supplychainanalytics`\
**Current tools:** MySQL, SQL, MySQL Workbench\
**Planned tool:** Microsoft Power BI
