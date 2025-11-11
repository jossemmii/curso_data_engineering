{{
    config(
        materialized='view'
    )
}}

WITH src_products AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'products')}}
    ),

transformed_products AS (
    SELECT
        md5(product_id) as product_id,
        name,
        price,
        inventory
    FROM src_products
)

SELECT * FROM transformed_products