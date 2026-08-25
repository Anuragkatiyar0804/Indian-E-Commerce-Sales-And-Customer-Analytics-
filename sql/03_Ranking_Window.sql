-- Question 5 :extract customers within each Customer_Tier by Total_Spent and list the top 3 per tier.

select customer_id, customer_name, customer_tier, total_spent
from( 
    select customer_id , customer_name, customer_tier , total_spent ,
row_number() over( partition by customer_tier order by total_spent desc ) as rn
from customers
) as ranked_customers
where rn <= 3;

-- Question 6: Find the top 5 products by revenue within each category, using RANK()

with amount_per_product as (
    select product_id, sum(total_amount) as net_amount
    from sales
    group by product_id
)
select product_id, product_name, category, net_amount
from(
select p.product_id, p.product_name, p.category, s.net_amount ,
rank() over(partition by p.category order by s.net_amount desc) as rnk
from amount_per_product s 
join products p 
on s.product_id = p.product_id) as ranked_products
where rnk <= 5;