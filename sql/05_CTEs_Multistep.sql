-- Question 9: Customers with above-average cancellation rate

with customer_cancellation as (
    select 
        Customer_ID,
        count(*) as total_orders,
        sum(case when Order_Status = 'Cancelled' then 1 else 0 end) as cancelled_orders,
        round(sum(case when Order_Status = 'Cancelled' then 1 else 0 end) / count(*) * 100, 2) as cancellation_rate
    from sales
    group by Customer_ID
),
avg_cancellation as (
    select avg(cancellation_rate) as overall_avg_rate
    from customer_cancellation
)
select c.Customer_ID, c.total_orders, c.cancelled_orders, c.cancellation_rate
from customer_cancellation c
cross join avg_cancellation a
where c.cancellation_rate > a.overall_avg_rate
order by c.cancellation_rate desc;

-- Question 10: Find products where the return rate exceeds 10%, joined with their average rating, to check if low ratings correlate with high returns.


with product_returns as (
    select 
        Product_ID,
        count(*) as total_orders,
        sum(case when Order_Status = 'Returned' then 1 else 0 end) as returned_orders,
        round(sum(case when Order_Status = 'Returned' then 1 else 0 end) / count(*) * 100, 2) as return_rate
    from sales
    group by Product_ID
)
select 
    p.Product_ID,
    p.Product_Name,
    p.Avg_Rating,
    pr.total_orders,
    pr.returned_orders,
    pr.return_rate
from product_returns pr
join products p on pr.Product_ID = p.Product_ID
where pr.return_rate > 10
order by pr.return_rate desc;

-- Question 11 : Orders stuck in Processing beyond the expected delivery window

with reference_date as (
    select max(Order_Date) as max_order_date
    from sales
)
select 
    s.Order_ID,
    s.Customer_ID,
    s.Order_Date,
    r.max_order_date,
    datediff(r.max_order_date, s.Order_Date) as days_since_order,
    case 
        when datediff(r.max_order_date, s.Order_Date) > 7 then 'Stuck'
        else 'Within Window'
    end as processing_status
from sales s
cross join reference_date r
where s.Order_Status = 'Processing'
order by days_since_order desc;