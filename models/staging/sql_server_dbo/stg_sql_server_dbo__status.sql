{{
    config(
        materialized='view'
    )
}}

WITH src_orders AS (
    SELECT DISTINCT status
    FROM {{ source('sql_server_dbo', 'orders')}}
    ),

transformed_status AS (
    SELECT
        md5(status) as status_id,
        status as status_desc
    FROM src_orders
)

SELECT * FROM transformed_status