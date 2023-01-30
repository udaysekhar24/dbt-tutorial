{{ config(
    materialized='incremental',
    unique_key='id',
    tags=['hourly']
) }}

WITH import_referral AS (
    SELECT 
        *
    FROM 
        {{ source('staging', 'stg_referral') }}
)

SELECT 
    *
FROM 
    import_referral