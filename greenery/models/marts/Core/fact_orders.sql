with orderitems as(
select order_id
    , count(product_id) as unique_items
    , sum(quantity) as total_items
from {{ ref('stg_postgres__order_items') }}
group by 1
)
select o.order_guid
     , o.user_guid
     , o.promo_id
     , o.created_at_utc
     , oi.unique_items
     , oi.total_items
     , o.order_cost
     , o.shipping_cost
     , o.order_total
     , o.shipping_service
     , o.estimated_delivery_at_utc
     , o.delivered_at_utc
     , o.status
from {{ ref('stg_postgres__orders') }} o 
left join orderitems oi on o.order_guid = oi.order_id