{{ config(materialized='ephemeral') }}


SELECT 
    ReferralGKey,
    IdBKey AS ReferralId,
    IsOutbound,
    Status,
    CreatedAt,
    UpdatedAt
FROM
    {{ source('dw', 'DimReferral') }}
