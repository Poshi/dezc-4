{{ config(materialized="view") }}

with
    tripdata as (
        select *
        from {{ source("staging", "fhv_tripdata") }}
    )
select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(["dispatching_base_num", "pickup_datetime", "dropoff_datetime", "PULocationID", "DOLocationID"]) }} as tripid,

    -- locations
    {{ dbt.safe_cast("PULocationID", api.Column.translate_type("integer")) }} as pickup_locationid,
    {{ dbt.safe_cast("DOLocationID", api.Column.translate_type("integer")) }} as dropoff_locationid,

    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,

    -- extra info
    dispatching_base_num,
    SR_Flag,
    Affiliated_base_number

from tripdata
where
        EXTRACT(YEAR from pickup_datetime) = 2019
    and PULocationID is not null
    and DOLocationID is not null


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var("is_test_run", default=true) %}
    limit 100
{% endif %}
