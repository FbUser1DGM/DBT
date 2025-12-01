{{ config(materialized='view') }}

SELECT
    ORDER_ITEM_ID      AS order_item_id,
    ORDER_ID           AS order_id,
    PRODUCT_ID         AS product_id,
    PRODUCT_NAME       AS product_name,
    CATEGORY           AS category,
    UNIT_PRICE         AS unit_price,
    QUANTITY           AS quantity,
    DISCOUNT_AMOUNT    AS discount_amount,
    (UNIT_PRICE * QUANTITY - DISCOUNT_AMOUNT) AS line_revenue,
    CREATED_AT         AS created_at
FROM {{ source('RAW', 'RAW_ORDER_ITEMS') }}
