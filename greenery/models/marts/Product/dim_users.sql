with users as (
select * from {{ ref('stg_postgres__users') }}
)

select 
    user_guid,
    first_name,
    last_name,
    email,
    phone_number,
    address_guid
from users