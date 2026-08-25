--Question 7 (Time-based, window functions): Calculate month-over-month revenue growth using LAG(), for delivered orders only.

with monthly_revenue as (
    select 
        sum(total_amount) as revenue,
        date_format(order_date, '%Y-%m') as order_month
    from sales
    where order_status = 'Delivered'
    group by order_month
),
with_growth as (
    select order_month, revenue,
        lag(revenue) over(order by order_month) as previous_month_revenue
    from monthly_revenue
)
select order_month, revenue, previous_month_revenue,
    round((revenue - previous_month_revenue) / previous_month_revenue * 100, 2) as growth_percent
from with_growth;

--Question 8: Compare average order value between customers who used a coupon vs. those who didn't, by quarter.

select 
    concat(year(order_date), '-Q', quarter(order_date)) as order_quarter,
    case when coupon_code is not null then 'Used Coupon' else 'No Coupon' end as coupon_usage,
    round(avg(total_amount), 2) as avg_order_value
from sales
group by order_quarter, coupon_usage
order by order_quarter, coupon_usage;