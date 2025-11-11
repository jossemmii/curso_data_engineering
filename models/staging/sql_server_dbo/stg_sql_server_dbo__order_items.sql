{{
    config(
        materialized='view'
    )
}}

WITH src_order_items AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'order_items')}}
    ),

transformed_order_items AS (
    SELECT
        md5(order_id) as order_id,
        md5(product_id) as product_id,
        quantity
    FROM src_order_items
)

SELECT * FROM transformed_order_items