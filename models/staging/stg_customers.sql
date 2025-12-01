{{ config(materialized='view') }}

SELECT
    CUSTOMER_ID        AS customer_id,
    CUSTOMER_NAME      AS customer_name,
    EMAIL              AS email,
    COUNTRY            AS country,
    CREATED_AT         AS created_at
FROM {{ source('RAW', 'RAW_CUSTOMERS') }}
