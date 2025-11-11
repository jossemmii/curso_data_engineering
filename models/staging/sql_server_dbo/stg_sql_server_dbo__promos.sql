{{
    config(
        materialized='view'
    )
}}

WITH src_promos AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'promos')}}
    ),

transformed_promos AS (
    SELECT
        md5(promo_id) AS promo_id,
        promo_id AS promo_name,
        discount AS discount_usd,
        status,
        _fivetran_deleted,
        _fivetran_synced as _fivetran_synced_UTC
    FROM src_promos

    UNION ALL
    
    SELECT
        md5('no promo') AS promo_id,
        'no promo' AS promo_name,
        null AS discount_usd,
        null AS status,
        null AS _fivetran_deleted,
        current_timestamp(9) as _fivetran_synced_UTC
    )

SELECT * FROM transformed_promos