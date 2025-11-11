{{
    config(
        materialized='view'
    )
}}

WITH src_orders AS (
    SELECT DISTINCT shipping_service
    FROM {{ source('sql_server_dbo', 'orders')}}
    ),

shipping_service AS (
    SELECT
        md5(
            CASE 
                WHEN TRIM(shipping_service) = '' THEN 'Not selected'
                ELSE TRIM(shipping_service)
            END
        ) AS shipping_service_id,
        CASE 
            WHEN TRIM(shipping_service) = '' THEN 'Not selected'
            ELSE TRIM(shipping_service)
        END AS shipping_service_description
    FROM src_orders
)

SELECT * FROM shipping_service