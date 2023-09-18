{{ config(materialized='table') }}

select
    address_id,
    address,
    zipcode,
    state as states,
    country
from {{source('postgres', 'addresses')}}