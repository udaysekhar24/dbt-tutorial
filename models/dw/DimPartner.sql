{{ config(
    materialized='table',
    unique_key='PartnerGKey'
) }}

WITH import_partner AS (
    SELECT 
        *
    FROM
        {{ source('master', 'partner') }}
)
SELECT 
    id AS IdBKey,
    partner_type AS Type,
    created_at AS CreatedAt,
    updated_at AS UpdatedAt,
    FARM_FINGERPRINT(CONCAT(CAST(id AS STRING), partner_type)) AS PartnerGkey
FROM 
    import_partner