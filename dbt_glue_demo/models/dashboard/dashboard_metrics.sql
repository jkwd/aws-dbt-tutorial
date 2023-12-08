{{
  config(
    materialized='incremental',
    incremental_strategy = 'merge',
    table_type='iceberg',
    unique_key = ["year", "month", "type"],
    format='parquet'
  )
}}
SELECT cm.avg_cost_per_minute
    , cm.avg_cost_per_distance
    , pm.avg_cost_per_passenger
    , pm.avg_duration_per_passenger
    , pm.avg_trip_distance_per_passenger
    , cm.year
    , cm.month
    , cm.type
FROM {{ ref('gold_passengers_metrics') }} as pm
LEFT JOIN {{ ref('gold_cost_metrics') }} as cm
    ON cm.type = pm.type
    AND cm.year = pm.year
    AND cm.month = pm.month