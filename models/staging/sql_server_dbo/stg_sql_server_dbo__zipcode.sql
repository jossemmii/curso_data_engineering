{{
    config(
        materialized='view'
    )
}}

WITH src_addresses AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'addresses')}}
    ),

zipcode_transformed AS (
    SELECT 
        md5(zipcode) as zipcode_id,
        zipcode as zipcode_desc,
        md5(state) as state_id
    FROM src_addresses
)

SELECT * FROM zipcode_transformed