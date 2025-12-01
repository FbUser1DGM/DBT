{{ config(materialized='table') }}

SELECT
    customer_id,
    customer_name,
    email,
    country,
    created_at AS customer_created_at
FROM {{ ref('stg_customers') }}
