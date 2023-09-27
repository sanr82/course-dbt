{{ config(materialized='table') }}

select
    address_id as address_guid,
    address,
    zipcode,
    state as states,
    country
from {{source('postgres', 'addresses')}}