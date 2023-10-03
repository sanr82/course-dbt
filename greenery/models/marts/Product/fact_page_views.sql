with session_timing as (
select *
from {{ ref('int_session_timing') }}
)

{% set event_types = dbt_utils.get_column_values(
    table=ref('stg_postgres__events'), 
    column='event_type'
    )
%}


select
  e.session_id
, e.user_guid
, coalesce(e.product_id, oi.product_id) as product_id
, st.session_started_at
, st.session_ended_at,
{% for event_type in event_types %}
{{ sum_of('e.event_type', event_type)}} as {{event_type}}s,
--sum(case when e.event_type = '{{event_type}}' then 1 else 0 end) as {{event_type }}s,
{% endfor %}
--, sum(case when e.event_type='page_view' then 1 else 0 end) as page_views
--, sum(case when e.event_type='add_to_cart' then 1 else 0 end) as add_to_carts
--, sum(case when e.event_type='checkout' then 1 else 0 end )as checkouts
--, sum (case when e.event_type='package_shipped' then 1 else 0 end) as packages_shipped
datediff('minute', session_started_at, session_ended_at) as session_length_minutes
from {{ ref('stg_postgres__events') }} e 
left join dev_db.dbt_sanr82gmailcom.stg_postgres__order_items oi 
   on oi.order_id = e.order_id
left join session_timing st on st.session_id = e.session_id
group by all