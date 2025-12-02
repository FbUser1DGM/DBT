{{ config(materialized='view') }}

select
    ORDER_DATE,
    PRODUCT_ID,
    sum(QUANTITY)        as UNITS_SOLD,
    sum(NET_LINE_AMOUNT) as REVENUE
from {{ ref('fct_product_sales') }}
group by 1, 2