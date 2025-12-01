{{ config(materialized='view') }}

SELECT
    ORDER_ID           AS order_id,
    CUSTOMER_ID        AS customer_id,
    ORDER_DATE         AS order_date,
    ORDER_STATUS       AS order_status,
    PAYMENT_METHOD     AS payment_method,
    CREATED_AT         AS created_at
FROM {{ source('RAW', 'RAW_ORDERS') }}
