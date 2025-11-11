{{
    config(
        materialized='view'
    )
}}

WITH src_orders AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'orders')}}
    ),

transformed_orders AS (
    SELECT 
        md5(order_id) as order_id,
        md5(TRIM(shipping_service)) AS shipping_service_id,     -- Shipping_Service_Id para el nuevo modelo shipping_Service
        shipping_cost as shipping_cost_usd,    
        md5(address_id) as address_id,
        CONVERT_TIMEZONE('Europe/Madrid', created_at) as created_at_utc,
        md5(IFF(TRIM(promo_id) = '', 'no promo', promo_id)) as promo_id,
        CONVERT_TIMEZONE('Europe/Madrid', estimated_delivery_at) as estimated_delivery_at_utc,
        md5(NULLIF(TRIM(user_id),'')) as user_id,
        CONVERT_TIMEZONE('Europe/Madrid', delivered_at) as delivered_at_utc,
        md5(tracking_id) as tracking_id,
        md5(status) as status_id,
        status
    FROM src_orders
)

SELECT * FROM transformed_orders