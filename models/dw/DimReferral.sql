{{ config(
    materialized='table',
    unique_key='ReferralGKey'
) }}

WITH import_referral AS (
    SELECT 
        *
    FROM
        {{ source('getground_master', 'referral') }}
)
SELECT 
    id AS IdBKey,
    status AS Status,
    is_outbound AS IsOutbound,
    created_at as CreatedAt,
    updated_at as UpdatedAt,
    FARM_FINGERPRINT(CONCAT(CAST(id AS STRING), status, is_outbound)) AS ReferralGkey
FROM 
    import_referral