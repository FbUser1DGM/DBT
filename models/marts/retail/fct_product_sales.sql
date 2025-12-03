{{ config(
    materialized = 'incremental',
    unique_key   = 'ORDER_ITEM_ID',
    on_schema_change = 'sync_all_columns'
) }}

with orders as (
    select *
    from {{ ref('stg_retail_orders') }}
),

items as (
    select *
    from {{ ref('stg_retail_order_items') }}

    {% if is_incremental() %}
      where LOADED_AT > (
        select coalesce(max(LOADED_AT), '1900-01-01'::timestamp_ntz)
        from {{ this }}
      )
    {% endif %}
),

joined as (
    select
        i.ORDER_ITEM_ID,
        i.ORDER_ID,
        o.ORDER_DATE,
        o.CUSTOMER_ID,
        o.STORE_ID,
        i.PRODUCT_ID,
        i.QUANTITY,
        i.UNIT_PRICE,
        i.DISCOUNT_AMOUNT,
        i.TAX_AMOUNT,
        i.LINE_AMOUNT              as GROSS_LINE_AMOUNT,
        (i.LINE_AMOUNT - i.DISCOUNT_AMOUNT) as NET_LINE_AMOUNT,
        o.ORDER_CHANNEL,
        o.CURRENCY,
        greatest(o.ORDER_TS, i.LOADED_AT) as LOADED_AT
        bogus_column as WILL_BREAK 
    from items i
    join orders o
      on i.ORDER_ID = o.ORDER_ID
)

select * from joined
