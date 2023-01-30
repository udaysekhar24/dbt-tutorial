{{ config(
    materialized='table',
    unique_key='SysUniqGKey'
) }}

WITH import_partner AS (
    SELECT 
        id,
        lead_sales_contact
    FROM
        {{ source('master', 'partner') }}
)
, import_dim_partner AS (
    SELECT 
        IdBKey,
        PartnerGKey
    FROM
        {{ source('dw', 'DimPartner') }}
)
, import_dim_salesperson AS (
    SELECT
        SalesPersonGKey,
        Name
    FROM
        {{ source('dw', 'DimSalesPerson') }}
)

SELECT
   dp.PartnerGKey,
   dsp.SalesPersonGKey,
   FARM_FINGERPRINT(
    CONCAT(
        CAST(dp.IdBKey AS STRING),
        lead_sales_contact
    )) AS SysUniqGKey
FROM 
    import_partner mp
JOIN
    import_dim_partner dp 
ON  mp.id = dp.IdBKey
JOIN
    import_dim_salesperson dsp 
ON  mp.lead_sales_contact = dsp.Name