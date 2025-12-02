{{ config(
    materialized = 'incremental',
    unique_key   = 'TRANSACTION_ID',
    on_schema_change = 'sync_all_columns'
) }}

with tx as (
    select *
    from {{ ref('stg_bank_transactions') }}

    {% if is_incremental() %}
      where LOADED_AT > (
        select coalesce(max(LOADED_AT), '1900-01-01'::timestamp_ntz)
        from {{ this }}
      )
    {% endif %}
),

labels as (
    select *
    from {{ ref('stg_fraud_labels') }}
),

joined as (
    select
        tx.TRANSACTION_ID,
        tx.ACCOUNT_ID,
        tx.CARD_ID,
        tx.CUSTOMER_ID,
        tx.TRANSACTION_TS,
        tx.POSTING_DATE,
        tx.AMOUNT           as AMOUNT_LOCAL,
        tx.CURRENCY,
        tx.MERCHANT_ID,
        tx.MERCHANT_CATEGORY,
        tx.CHANNEL,
        tx.COUNTRY,
        tx.STATUS,
        tx.IS_INTERNATIONAL,
        lbl.LABEL           as FRAUD_LABEL,
        lbl.LABEL_REASON,
        lbl.LABEL_SOURCE,
        tx.LOADED_AT
    from tx
    left join labels lbl
      on tx.TRANSACTION_ID = lbl.TRANSACTION_ID
)

select * from joined
