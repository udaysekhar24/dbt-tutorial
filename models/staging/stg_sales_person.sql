{{ config(materialized='table') }}

WITH import_sales_person AS (
    SELECT 
        *
    FROM 
        {{ source('seed_data', 'sales_people') }}
)

SELECT 
    *
FROM 
    import_sales_person