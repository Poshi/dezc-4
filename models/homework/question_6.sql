{{ config(materialized='view') }}

select
  service_type,
  p97,
  p95,
  p90
from
  {{ ref('fct_taxi_trips_monthly_fare_p95') }}
where
      year = '2020'
  and month = '04'
