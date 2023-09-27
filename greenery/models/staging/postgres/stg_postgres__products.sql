{{ config(materialized='table') }}

select
    product_id as product_guid,
    name as product_name,
    price,
    inventory
from {{source('postgres', 'products')}}