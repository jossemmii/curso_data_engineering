{{
    config(
        materialized='view'
    )
}}

WITH src_users AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'users')}}
    ),

transformed_users AS (

    SELECT
        md5(user_id) as user_id,
        first_name,
        last_name,
        email,
        CONVERT_TIMEZONE('Europe/Madrid', created_at) as created_at_utc,
        phone_number,
        CONVERT_TIMEZONE('Europe/Madrid', updated_at) as updated_at_utc,
        md5(address_id) as address_id
    FROM src_users

)

SELECT * FROM transformed_users
