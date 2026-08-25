-- 3 question : Calculate total revenue (Total_Amount) by product category, considering only Delivered orders.

select p.Category, sum(s.Total_Amount) as Total_Revenue
from sales s
join products p on s.Product_ID = p.Product_ID
where s.Order_Status = 'Delivered'
group by p.Category
order by Total_Revenue desc;

-- Question 4: Find the average delivery time (Delivery_Date - Order_Date) by state.

select State, avg(datediff(Delivery_Date , Order_Date)) as Avg_Delivery_Time
from sales 
group by State
order by Avg_Delivery_Time desc;