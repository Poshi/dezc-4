{{ config(materialized='view') }}

with
  tripdata as (
    select
      pickup_zone,
      dropoff_zone,
      p90,
      row_number() over (partition by pickup_zone order by p90 desc) as rn
    from
      {{ ref('fct_fhv_monthly_zone_traveltime_p90') }}
    where
          pickup_zone in ('Newark Airport', 'SoHo', 'Yorkville East')
      and year = '2019'
      and month = '11'
    order by
      pickup_zone, p90 desc
  )
select
  pickup_zone,
  dropoff_zone,
  p90
from
  tripdata
where
  rn = 2