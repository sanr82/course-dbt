How many users do we have?

Answer: 130
--------
select count(user_id) as number_of_users from stg_postgres__users;
---------

On average, how many orders do we receive per hour?

Answer: 7.520833
-----------------
with num_of_orders_per_hour as (
select date_trunc(hour,created_at_utc) as created_at_hour,
       count(order_id) as number_of_orders 
from stg_postgres__orders group by 1
)
select avg(number_of_orders) from num_of_orders_per_hour;
-------------------

On average, how long does an order take from being placed to being delivered?

Answer: 3.891803 days
----------------------
with time_difference as (
select order_id, 
timestampdiff(day,created_at_utc, delivered_at_utc) as time_taken,
created_at_utc,
delivered_at_utc
from stg_postgres__orders
)
select Avg(time_taken) as average_time_taken_to_complete_the_order from time_difference
where time_taken is not null;
------------------------

How many users have only made one purchase? Two purchases? Three+ purchases?

Answers: 25 users made one purchase, similarly 28 users made two purchases and 71 users have made more than or equal to 3 purchases.
--------------------------
with num_of_purchases as (
select user_id, 
       count(distinct order_id) as purchase
from stg_postgres__orders
group by user_id
)
select  count(case when purchase =1 then 1 else null end) as "one_purchase",
        count(case when purchase =2 then 1 else null end) as "two_purchases",
        count(case when purchase >=3 then 1 else null end) as "three_purchases"
from num_of_purchases
where purchase is not null;
-----------------------------

On average, how many unique sessions do we have per hour?

Answers: 16.327
---------------------
with unique_sessions as (
select date_trunc(hour, created_at_utc) as hours, 
       count(distinct session_id) as sessions
from stg_postgres__events
group by 1 
)
select avg(sessions) as unique_session_per_hour from unique_sessions ;
-----------------------