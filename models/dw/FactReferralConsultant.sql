{{ config(
    materialized='table',
    unique_key='SysUniqGKey'
) }}

WITH import_referral AS (
    SELECT 
        id,
        consultant_id,
        company_id,
        partner_id
    FROM
        {{ source('master', 'referral') }}
)
, import_dim_partner AS (
    SELECT 
        IdBKey,
        PartnerGKey
    FROM
        {{ source('dw', 'DimPartner') }}
)
, import_dim_referral AS (
    SELECT
        IdBKey,
        ReferralGKey
    FROM
        {{ source('dw', 'DimReferral') }}
)

SELECT
   dp.PartnerGKey,
   dr.ReferralGKey,
   mr.company_id AS CompanyIdBKey,
   mr.consultant_id AS ConsultantIdBKey,
   FARM_FINGERPRINT(
    CONCAT(
        CAST(dp.IdBKey AS STRING),
        CAST(dr.IdBKey AS STRING),
        CAST(mr.company_id AS STRING),
        CAST(mr.consultant_id AS STRING)
    )) AS SysUniqGKey
FROM 
    import_referral mr
JOIN
    import_dim_partner dp 
ON  mr.partner_id = dp.IdBKey
JOIN
    import_dim_referral dr 
ON  dr.IdBKey = mr.Id