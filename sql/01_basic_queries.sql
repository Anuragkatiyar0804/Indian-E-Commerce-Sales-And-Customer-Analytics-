-- question 1: Customers with cancelled orders and Platinum tier

select * 
from customers c join sales s 
on c.Customer_ID = s.Customer_ID
where s.order_status = 'Cancelled'
and c.Customer_Tier = 'Platinum';

-- Question 2: Products in Electronics with discount > 40%

select *
from products
where category = 'Electronics'
and Discount_Percent > 40;