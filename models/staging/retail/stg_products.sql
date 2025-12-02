select
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY_PATH,
    split_part(CATEGORY_PATH, '>', 1) as CATEGORY_L1,
    split_part(CATEGORY_PATH, '>', 2) as CATEGORY_L2,
    BRAND,
    CURRENT_PRICE,
    COST_PRICE,
    STATUS,
    CREATED_AT,
    UPDATED_AT,
    INGESTED_AT as LOADED_AT
from {{ source('RAW', 'PRODUCTS') }}
