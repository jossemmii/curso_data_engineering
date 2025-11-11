{{
    config(
        materialized='view'
    )
}}

WITH src_addresses AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'addresses')}}
    ),

country_transformed AS (

    SELECT
        md5(country) as country_id,
        country as country_desc
    FROM src_addresses

)

SELECT * FROM country_transformed