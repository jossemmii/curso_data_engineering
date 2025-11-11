{{
    config(
        materialized='view'
    )
}}

WITH src_addresses AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'addresses')}}
    ),

transformed_addresses AS (
    SELECT
        md5(address_id) as address_id,
        address as address_desc,
        md5(zipcode) as zipcode_id
    FROM src_addresses
)

SELECT * FROM transformed_addresses

