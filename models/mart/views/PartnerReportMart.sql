WITH LatestDimPartner AS (
    SELECT * FROM {{ ref('LatestDimPartner') }}
),

LatestDimSalesPerson AS (
    SELECT * FROM {{ ref('LatestDimSalesPerson') }}
),

final AS (
    SELECT
        (SELECT AS STRUCT dim_p.* EXCEPT (PartnerGKey)) AS Partner,
        (SELECT AS STRUCT dim_sp.* EXCEPT (SalesPersonGKey)) AS SalesPerson
    FROM
        {{ source('dw', 'FactPartnerSalesPerson')}} fact_p_sp
    LEFT JOIN
        LatestDimPartner dim_p
    ON fact_p_sp.PartnerGKey = dim_p.PartnerGKey
    LEFT JOIN
        LatestDimSalesPerson dim_sp
    ON fact_p_sp.SalesPersonGKey = dim_sp.SalesPersonGKey
)

SELECT
    *
FROM
    final
