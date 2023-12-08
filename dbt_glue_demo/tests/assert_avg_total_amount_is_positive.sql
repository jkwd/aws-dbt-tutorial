select
    year
    , month
    , type
    avg_total_amount
from {{ ref('silver_avg_metrics' )}}
where avg_total_amount < 0