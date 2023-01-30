{{ config(
    materialized='table',
    tags=['hourly']
) }}

WITH import_referral AS (
    SELECT 
        *
    FROM 
        {{ source('getground_seed_data', 'referrals') }}
)

SELECT 
    * EXCEPT(created_at, updated_at),
    -- Convert UNIX Nano to BigQuery Timestamp datatype
    {{ unix_nano_to_timestamp('created_at') }} AS created_at,
    {{ unix_nano_to_timestamp('updated_at') }} AS updated_at
FROM 
    import_referral