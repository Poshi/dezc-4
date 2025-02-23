{{ config(materialized='view') }}

with
    fhv_tripdata as (
        select *, 
        from {{ ref('stg_fhv_tripdata') }}
    )
select
    *,
    format_date('%Y', pickup_datetime) as year,
    format_date('%m', pickup_datetime) as month,
    format_date('%Q', pickup_datetime) as quarter,
    format_date('%Y/Q%Q', pickup_datetime) as year_quarter
from
    fhv_tripdata
