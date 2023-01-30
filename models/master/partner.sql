{{ config(
    materialized='table',
    unique_key='id'
) }}

WITH import_partner AS (
    SELECT 
        *
    FROM
        {{ source('getground_staging', 'stg_partner') }}
)
-- Load only partners with vaild sales person contact.
SELECT 
    *,
    TIMESTAMP_TRUNC(created_at, DAY) as master_created_date
FROM 
    import_partner p
WHERE
    EXISTS (
        SELECT 
            1 
        FROM 
            {{ ref('sales_person') }} sp 
        WHERE 
            p.lead_sales_contact = sp.name
    )