{{ config(materialized='table') }}

WITH order_items AS (
    SELECT
        oi.order_id,
        SUM(oi.line_revenue) AS order_revenue,
        SUM(oi.quantity)     AS total_items
    FROM {{ ref('stg_order_items') }} AS oi
    GROUP BY oi.order_id
),

base_orders AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        o.order_status,
        o.payment_method,
        o.created_at,
        oi.order_revenue,
        oi.total_items
    FROM {{ ref('stg_orders') }} AS o
    LEFT JOIN order_items AS oi
      ON o.order_id = oi.order_id
)

SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    payment_method,
    order_revenue,
    total_items,
    created_at AS order_created_at
FROM base_orders
