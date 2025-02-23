{{ config(materialized='table') }}

with
    tripdata as (
        select *
        from {{ ref('fct_taxi_tripdata') }}
        where year between '2019' and '2020'
    )
SELECT
    service_type,
    year_quarter,
    year,
    quarter,
    LAG(SUM(total_amount)) OVER (PARTITION BY service_type, quarter ORDER BY year) AS prev_revenue,
    SUM(total_amount) AS revenue,
    ((SUM(total_amount) / NULLIF(LAG(SUM(total_amount)) OVER (PARTITION BY service_type, quarter ORDER BY year), 0)) - 1) * 100 AS YoY_percentage
FROM
    tripdata
GROUP BY
    service_type,
    year_quarter,
    year,
    quarter
ORDER BY
    service_type, year, quarter