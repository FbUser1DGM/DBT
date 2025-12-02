select
    ORDER_ITEM_ID,
    ORDER_ID,
    PRODUCT_ID,
    QUANTITY,
    UNIT_PRICE,
    DISCOUNT_AMOUNT,
    TAX_AMOUNT,
    LINE_AMOUNT,
    INGESTED_AT as LOADED_AT
from {{ source('RAW', 'ORDER_ITEMS') }}
