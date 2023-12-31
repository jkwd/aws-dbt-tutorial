{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['year', 'month', 'type'],
        file_format = 'parquet'
    )
}}

WITH source_avg as ( 
    SELECT avg((CAST(dropoff_datetime as LONG) - CAST(pickup_datetime as LONG))/60) as avg_duration 
    , avg(passenger_count) as avg_passenger_count 
    , avg(trip_distance) as avg_trip_distance 
    , avg(total_amount) as avg_total_amount
    , year
    , month 
    , type
    FROM {{ source('data_source', 'records') }} 
    WHERE year = "2016"
    AND dropoff_datetime is not null 
    GROUP BY year, month, type
) 
SELECT *
FROM source_avg
