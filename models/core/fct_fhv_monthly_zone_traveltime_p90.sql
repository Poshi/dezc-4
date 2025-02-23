{{ config(materialized='table') }}

with
  tripdata as (
    select *, timestamp_diff(dropoff_datetime, pickup_datetime, SECOND) as trip_duration
    from {{ ref('dim_fhv_trips') }}
  ),
  percentiles as (
    SELECT
      year,
      month,
      pickup_locationid,
      dropoff_locationid,
      pickup_borough,
      pickup_zone,
      dropoff_borough,
      dropoff_zone,
      PERCENTILE_CONT(trip_duration, 0.90) OVER (PARTITION BY year, month, pickup_locationid, dropoff_locationid) AS p90
    FROM
      tripdata
  )
SELECT
  year,
  month,
  pickup_locationid,
  dropoff_locationid,
  pickup_borough,
  pickup_zone,
  dropoff_borough,
  dropoff_zone,
  p90
FROM
  percentiles
GROUP BY
  year,
  month,
  pickup_locationid,
  dropoff_locationid,
  pickup_borough,
  pickup_zone,
  dropoff_borough,
  dropoff_zone,
  p90