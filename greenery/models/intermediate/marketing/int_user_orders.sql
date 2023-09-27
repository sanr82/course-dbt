select user_guid
     , min(created_at_utc) as first_order_created_at
     , max(created_at_utc) as last_order_created_at
     , sum(order_cost) as total_spend
     , count(order_guid) as orders
from {{ ref('stg_postgres__orders') }}
group by 1