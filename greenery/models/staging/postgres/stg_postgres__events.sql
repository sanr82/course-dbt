{{ config(materialized='table') }}

select
    event_id,
    session_id,
    user_id as user_guid,
    page_url,
    created_at as created_at_utc,
    event_type,
    order_id,
    product_id
from {{source('postgres', 'events')}}