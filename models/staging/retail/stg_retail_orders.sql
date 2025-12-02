select
    ORDER_ID,
    CUSTOMER_ID,
    ORDER_TS,
    cast(ORDER_TS as date) as ORDER_DATE,
    upper(ORDER_STATUS) as ORDER_STATUS,
    upper(ORDER_CHANNEL) as ORDER_CHANNEL,
    STORE_ID,
    CURRENCY,
    TOTAL_AMOUNT,
    INGESTED_AT as LOADED_AT
from {{ source('RAW', 'ORDERS') }}