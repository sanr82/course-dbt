Part-1
Question 1: Run the products snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. 

SQL:

with last_week as (
select *, dense_rank() over (order by dbt_updated_at desc) as weeks_ordered
from product_snapshot
)
select * from last_week 
where weeks_ordered <=2
order by product_id

Question 2: Which products had their inventory change from week 3 to week 4? 

SQL:

with week3 as (
select * from (
select dense_rank() over (order by dbt_updated_at desc) as rank, product_id, name, inventory as week3_inventory, dbt_updated_at from product_snapshot)
where rank = 2
),
week4 as (
select * from (
select dense_rank() over (order by dbt_updated_at desc) as rank, product_id, name, inventory as week4_inventory, dbt_updated_at from product_snapshot)
where rank = 1
)

select name from week3 inner join week4 using (product_id)
where week3_inventory <> week4_inventory

Answers:
Bamboo
Monstera
Philodendron
ZZ Plant
String of pearls
Pothos

Question 3: Now that we have 3 weeks of snapshot data, can you use the inventory changes to determine which products had the most fluctuations in inventory? Did we have any items go out of stock in the last 3 weeks? 

SQL: 

with inventory_per_week as (
select product_id, name, inventory, dense_rank() over (order by dbt_updated_at) as snapshot_week 
from product_snapshot
)
 select name as out_of_stock_products, snapshot_week as out_of_stock_week from inventory_per_week 
 where inventory = 0;

 Answers:

OUT_OF_STOCK_PRODUCTS	OUT_OF_STOCK_WEEK
Pothos	                  2
String of pearls	      2

SQL:

    select snap2.product_id, snap2.name, max(snap2.inventory) as highest_inventory, min(snap2.inventory) as lowest_inventory, (max(snap2.inventory) - min(snap2.inventory)) as inventory_change from product_snapshot snap2
    where  snap2.product_id in(
    select snap1.product_id from product_snapshot snap1
    group by snap1.product_id 
    having count(1) > 1)
    group by all
    order by  inventory_change desc;

Answers:

PRODUCT_ID	NAME	HIGHEST_INVENTORY	LOWEST_INVENTORY	INVENTORY_CHANGE
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	String of pearls	58	0	58
b66a7143-c18a-43bb-b5dc-06bb5d1d3160	ZZ Plant	89	41	48
be49171b-9f72-4fc9-bf7a-9a52e259836b	Monstera	77	31	46
4cda01b9-62e2-46c5-830f-b7f262a58fb1	Pothos	40	0	40
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	Philodendron	51	15	36
689fb64e-a4a2-45c5-b9f2-480c2155624d	Bamboo	56	23	33

Part-2

Utilized fact_page_views to query the snowflake to find below answers

How are our users moving through the product funnel?
  'page views' to 'add to cart' conversion is pretty good at an average of 50%
  'add to cart' to 'check out' is lower at an average of 40%

Which steps in the funnel have largest drop off points?
  'add to cart' to 'check out' has the largest drop point


Question 6: If your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?

Answer: We use DBT in Sigma and i am pretty sure the DBT models are designed more efficently as they are developed and owned by one of our instructor Jack hanan I'd request to make those models available for the support team in addition to the sample data set we have.

Question 7: If you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?

Answer: I have used ralph's kimbals dimensional modeling of star and snowflake schema in the past so familar with identifying dimensions and facts but learned how to do it in DBT and i still need lot of practise to use macros and jingas
