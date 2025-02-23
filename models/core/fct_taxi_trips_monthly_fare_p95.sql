{{ config(materialized='table') }}

with
    tripdata as (
        select service_type, year, month, quarter, year_quarter, fare_amount
        from {{ ref('fct_taxi_tripdata') }}
        where
                year between '2019' and '2020'
            and fare_amount > 0
            and trip_distance > 0
            and payment_type_description in ('Cash', 'Credit card')
    ),
    percentiles as (
        SELECT
            service_type,
            year,
            month,
            fare_amount,
            PERCENTILE_CONT(fare_amount, 0.90) OVER(PARTITION BY service_type, year, month) AS p90,
            PERCENTILE_CONT(fare_amount, 0.95) OVER(PARTITION BY service_type, year, month) AS p95,
            PERCENTILE_CONT(fare_amount, 0.97) OVER(PARTITION BY service_type, year, month) AS p97
        FROM
            tripdata
        ORDER BY
            service_type, fare_amount
    )

SELECT
    service_type, year, month, p90, p95, p97
FROM
    percentiles
GROUP BY
    service_type, year, month, p90, p95, p97