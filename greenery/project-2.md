Question 1: What is our user repeat rate?
-----------------------------------
formula: Repeat Rate = Users who purchased 2 or more times / users who purchased

SQL: with num_of_orders as (
    select
        user_guid,
        count(order_guid) as order_cnt
    from
        dev_db.dbt_sanr82gmailcom.STG_POSTGRES__ORDERS
    group by
        1
),
user_buckets as (select
        user_guid,
        (order_cnt >= 1)::int as has_one_plus_order,
            (order_cnt > 1)::int as has_two_plus_order
                from
                    num_of_orders)
select sum(has_two_plus_order) / sum(has_one_plus_order) as repeat_rate
from user_buckets;

Answer: 0.798387
---------------------------------------
Question: 3. Explain the product mart models you added. Why did you organize the models in the way you did? 
----------------------------------------
Answer: I created 3 marts as explained in week 2 project instructions and followed the project walkthrough video from Oleg and the three marts are 1. Product 2. Core and 3. Marketing
Within Products, I also created intermidiate layer to first create int_session_timing which then joined into a event table to form fact_page_views model 

In Core I've got order_items and order tables to join to create fact_orders. Again i just followed Oleg's video.

In Marketing I created an intermediate model, user_orders and then join it with order and order_items table to form fact_user_orders
-------------------------------------------
Question 4. What assumptions are you making about each model? (i.e. why are you adding each test?)
-------------------------------------------
Answer: I followed Oleg's video and mostly tested for uniqueness and not being null and also added a check for accepted values on event type and relationship of user_guid to stg_postgres__users table.
--------------------------------------------
Question 5. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
----------------------------------------------
Answer: No, all tests passed!
-----------------------------------------------
Question 6. Which products had their inventory change from week 1 to week 2?
-------------------------------------------------
SQL: select * from dev_db.dbt_sanr82gmailcom.product_snapshot 
where dbt_valid_to is not null

Answer: 
PRODUCT_ID
4cda01b9-62e2-46c5-830f-b7f262a58fb1
689fb64e-a4a2-45c5-b9f2-480c2155624d
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3
be49171b-9f72-4fc9-bf7a-9a52e259836b
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80
b66a7143-c18a-43bb-b5dc-06bb5d1d3160
----------------------------------------------

