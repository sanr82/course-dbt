with session_timing as (
select *
from {{ ref('int_session_timing') }}
)

select
  e.user_guid
, e.product_id
, e.order_id
, e.session_id
, st.session_started_at
, st.session_ended_at
, sum(case when e.event_type='page_view' then 1 else 0 end) as page_views
, sum(case when e.event_type='add_to_cart' then 1 else 0 end) as add_to_carts
, sum(case when e.event_type='checkout' then 1 else 0 end )as checkouts
, sum (case when e.event_type='package_shipped' then 1 else 0 end) as packages_shipped
, datediff('minute', session_started_at, session_ended_at) as session_length_minutes
from {{ ref('stg_postgres__events') }} e 
left join session_timing st on st.session_id = e.session_id
group by all