{{ config(
    materialized='table',
    unique_key='SalesPersonGKey'
) }}

WITH import_partner AS (
    SELECT 
        *
    FROM 
        {{ source('getground_master', 'sales_person') }}
)

SELECT 
    name as Name,
    country as Country,
    FARM_FINGERPRINT(CONCAT(name, country)) AS SalesPersonGKey
FROM 
    import_sales_person