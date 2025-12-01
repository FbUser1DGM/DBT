{{ config(
    materialized='table',
    schema='MARTS'
) }}

-- TIME_SPINE: ONE ROW PER DAY BETWEEN MIN AND MAX ORDER_DATES
with date_bounds as (

    select
        dateadd(day, -365, current_date) as min_date,  -- 1 year back (adjust as needed)
        dateadd(day, 365, current_date)  as max_date   -- 1 year forward (adjust as needed)

),

spine as (

    select
        seq4() as date_id,
        dateadd(
            day,
            seq4(),
            (select min_date from date_bounds)
        ) as date_day
    from table(generator(rowcount => 3 * 365))  -- generate ~3 years of days
)

select
    date_day as DATE_DAY
from spine
where date_day between (select min_date from date_bounds) and (select max_date from date_bounds)
order by DATE_DAY