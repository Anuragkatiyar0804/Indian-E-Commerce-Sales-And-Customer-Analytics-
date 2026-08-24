
-- Indian E-Commerce Sales Analytics Schema

CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;

-- Customers table
CREATE TABLE customers (
    Customer_ID           VARCHAR(20) PRIMARY KEY,
    Customer_Name         VARCHAR(100),
    Gender                VARCHAR(10),
    Age                   INT,
    Age_Group             VARCHAR(20),
    Date_of_Birth         DATE,
    Email                 VARCHAR(100),
    Phone                 VARCHAR(20),
    City                  VARCHAR(50),
    State                 VARCHAR(50),
    Pincode               VARCHAR(10),
    Registration_Date     DATE,
    Customer_Tier         VARCHAR(20),
    Total_Orders          INT,
    Total_Spent           DECIMAL(12,2)
);

-- Products table
CREATE TABLE products (
    Product_ID            VARCHAR(20) PRIMARY KEY,
    Product_Name          VARCHAR(150),
    Category              VARCHAR(50),
    Brand                 VARCHAR(50),
    Original_Price        DECIMAL(12,2),
    Discount_Percent      INT,
    Discount_Amount       DECIMAL(12,2),
    Selling_Price         DECIMAL(12,2),
    Stock_Quantity        INT,
    Weight_kg             DECIMAL(6,2),
    Avg_Rating            DECIMAL(3,2),
    Total_Reviews         INT
);

-- Sales table
CREATE TABLE sales (
    Order_ID                 VARCHAR(20) PRIMARY KEY,
    Customer_ID              VARCHAR(20),
    Product_ID               VARCHAR(20),
    Order_Date               DATE,
    Order_Time               TIME,
    Delivery_Date            DATE,
    Quantity                 INT,
    Unit_Price               DECIMAL(12,2),
    Order_Value              DECIMAL(12,2),
    Shipping_Cost            DECIMAL(10,2),
    Coupon_Code              VARCHAR(30),
    Coupon_Discount          DECIMAL(10,2),
    Total_Amount             DECIMAL(12,2),
    Payment_Mode             VARCHAR(30),
    Order_Status             VARCHAR(30),
    Rating                   DECIMAL(3,2),
    Review_Text              TEXT,
    City                     VARCHAR(50),
    State                    VARCHAR(50),
    Customer_Age             INT,
    Customer_Age_Group       VARCHAR(20),

    FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
);
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM sales;