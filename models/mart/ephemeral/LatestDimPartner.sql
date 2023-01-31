{{ config(materialized='ephemeral') }}


SELECT 
    PartnerGKey,
    IdBKey AS PartnerId,
    Type as PartnerType
FROM
    {{ source('dw', 'DimPartner') }}