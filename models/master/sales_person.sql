{{ config(
    materialized='table',
    cluster_by = "country"
) }}

WITH import_sales_person AS (
    SELECT 
        *
    FROM 
        {{ source('staging', 'stg_sales_person') }}
)

SELECT 
    *
FROM 
    import_sales_person