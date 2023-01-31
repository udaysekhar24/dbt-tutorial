{{ config(materialized='ephemeral') }}


SELECT 
    SalesPersonGKey,
    Name,
    Country
FROM
    {{ source('dw', 'DimSalesPerson') }}