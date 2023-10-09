{% snapshot orders_snapshot %}

{{
  config(
    target_database = target.database,
    target_schema = target.schema,
    strategy='check',
    unique_key='order_id',
    check_cols=['order_total'],
   )
}}

  SELECT * FROM {{ source('postgres', 'orders') }}

{% endsnapshot %}