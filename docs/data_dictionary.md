# Data Dictionary

## Important Assumption

`Delivery_Date` in this dataset represents an **expected delivery date, not an actual delivered-on date**. I confirmed this during the data quality check: the average gap between `Order_Date` and `Delivery_Date` is ~4.5 days across every single order status, including Cancelled and Processing orders — which would be impossible if it were a real delivery timestamp, since those orders were never actually delivered. I treated this as a documented assumption rather than a data error, and it shapes how I interpreted the "average delivery time by state" analysis (it reflects planned, not actual, delivery windows).

## customers

| Column | Type | Description |
|---|---|---|
| Customer_ID | VARCHAR(20), PK | Unique customer identifier |
| Customer_Name | VARCHAR(100) | Customer's full name |
| Gender | VARCHAR(10) | Customer's gender |
| Age | INT | Customer's age |
| Age_Group | VARCHAR(20) | Age bucket (e.g. 18-25, 26-35) |
| Date_of_Birth | DATE | Customer's date of birth |
| Email | VARCHAR(100) | Customer's email address |
| Phone | VARCHAR(20) | Customer's phone number |
| City | VARCHAR(50) | Customer's city |
| State | VARCHAR(50) | Customer's state |
| Pincode | VARCHAR(10) | Customer's postal code |
| Registration_Date | DATE | Date the customer registered on the platform |
| Customer_Tier | VARCHAR(20) | Loyalty tier — Silver, Gold, or Platinum |
| Total_Orders | INT | Total number of orders placed by the customer |
| Total_Spent | DECIMAL(12,2) | Total amount spent by the customer |

## products

| Column | Type | Description |
|---|---|---|
| Product_ID | VARCHAR(20), PK | Unique product identifier |
| Product_Name | VARCHAR(150) | Name of the product |
| Category | VARCHAR(50) | Product category (Electronics, Home, Sports, Fashion, Grocery, Beauty, Books) |
| Brand | VARCHAR(50) | Product brand |
| Original_Price | DECIMAL(12,2) | List price before discount |
| Discount_Percent | INT | Discount percentage applied |
| Discount_Amount | DECIMAL(12,2) | Discount amount in currency |
| Selling_Price | DECIMAL(12,2) | Final selling price after discount |
| Stock_Quantity | INT | Units in stock |
| Weight_kg | DECIMAL(6,2) | Product weight in kilograms |
| Avg_Rating | DECIMAL(3,2) | Average customer rating for the product |
| Total_Reviews | INT | Total number of reviews received |

## sales

| Column | Type | Description |
|---|---|---|
| Order_ID | VARCHAR(20), PK | Unique order identifier |
| Customer_ID | VARCHAR(20), FK | References `customers.Customer_ID` |
| Product_ID | VARCHAR(20), FK | References `products.Product_ID` |
| Order_Date | DATE | Date the order was placed |
| Order_Time | TIME | Time the order was placed |
| Delivery_Date | DATE | **Expected** delivery date (see assumption above) |
| Quantity | INT | Number of units ordered |
| Unit_Price | DECIMAL(12,2) | Price per unit at time of order |
| Order_Value | DECIMAL(12,2) | Total value of the order before shipping/discount adjustments |
| Shipping_Cost | DECIMAL(10,2) | Shipping cost for the order |
| Coupon_Code | VARCHAR(30), nullable | Coupon code used, if any (~80% of orders have no coupon) |
| Coupon_Discount | DECIMAL(10,2) | Discount amount from the coupon |
| Total_Amount | DECIMAL(12,2) | Final order amount charged to the customer |
| Payment_Mode | VARCHAR(30) | UPI, COD, Debit Card, or Credit Card |
| Order_Status | VARCHAR(30) | Delivered, Cancelled, Returned, Shipped, or Processing |
| Rating | DECIMAL(3,2), nullable | Customer rating for the order (~52% of orders have no rating) |
| Review_Text | TEXT, nullable | Customer's written review, if any |
| City | VARCHAR(50) | Delivery city |
| State | VARCHAR(50) | Delivery state |
| Customer_Age | INT | Customer's age at time of order |
| Customer_Age_Group | VARCHAR(20) | Customer's age bucket at time of order |

## Data Quality Summary

- No duplicate primary keys across any of the three tables.
- No orphaned foreign keys — every order in `sales` references a valid `Customer_ID` and `Product_ID`.
- `customers` and `products` have zero null values.
- Nulls in `sales.Coupon_Code`, `sales.Rating`, and `sales.Review_Text` are expected and left as-is — they represent orders with no coupon used or no review given, not missing/broken data.
