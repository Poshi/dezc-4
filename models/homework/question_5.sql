{{ config(materialized='view') }}

with
  tripdata as (
    select
      service_type,
      first_value(year_quarter) over (partition by service_type order by YoY_percentage desc rows between unbounded preceding and unbounded following) as best,
      last_value(year_quarter) over (partition by service_type order by YoY_percentage desc rows between unbounded preceding and unbounded following) as worst
    from
      {{ ref('fct_taxi_trips_quarterly_revenue') }}
    where
      year = '2020'
  )
select
  service_type,
  best,
  worst
from
  tripdata
group by
  service_type,
  best,
  worst