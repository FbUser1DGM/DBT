select
    TRANSACTION_ID,
    upper(LABEL) as LABEL,
    LABEL_REASON,
    LABEL_SOURCE,
    LABELED_AT,
    INGESTED_AT as LOADED_AT
from {{ source('RAW', 'FRAUD_LABELS') }}