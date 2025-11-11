{{
    config(
        materialized='view'
    )
}}

WITH src_addresses AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'addresses')}}
    ),

state_transformed AS (

    SELECT
        md5(state) as state_id,
        state as state_desc,
        md5(country) as country_id
    FROM src_addresses

)

SELECT * FROM state_transformed