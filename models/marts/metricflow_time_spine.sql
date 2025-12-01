{{ config(
    materialized = 'table',
    schema = 'MARTS'
) }}

-- DAILY TIME SPINE: ONE ROW PER DAY, ~10 YEARS RANGE (ADJUST AS NEEDED)

WITH base_dates AS (
    {{ dbt.date_spine(
        datepart = 'day',
        start_date = "DATE('2015-01-01')",
        end_date   = "DATE('2030-01-01')"
    ) }}
)

SELECT
    CAST(date_day AS DATE) AS DATE_DAY
FROM base_dates
WHERE DATE_DAY > DATEADD(year, -5, CURRENT_DATE())
  AND DATE_DAY < DATEADD(day, 30, CURRENT_DATE())
