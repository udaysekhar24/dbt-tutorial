WITH LatestDimPartner AS (
    SELECT * FROM {{ ref('LatestDimPartner') }}
),

LatestDimReferral AS (
    SELECT * FROM {{ ref('LatestDimReferral') }}
),

final AS (
    SELECT
        (SELECT AS STRUCT dim_p.* EXCEPT (PartnerGKey)) AS Partner,
        (SELECT AS STRUCT dim_r.* EXCEPT (ReferralGKey)) AS Referral,
        fact_r_c.CompanyIdBKey AS CompanyId,
        fact_r_c.ConsultantIdBKey AS ConsultantId
    FROM
        {{ source('dw', 'FactPartnerSalesPerson')}} fact_p_sp
    LEFT JOIN
        LatestDimPartner dim_p
    ON fact_p_sp.PartnerGKey = dim_p.PartnerGKey
    LEFT JOIN
        {{ source('dw', 'FactReferralConsultant')}} fact_r_c
    ON fact_r_c.PartnerGKey = dim_p.PartnerGKey
    LEFT JOIN
        LatestDimReferral dim_r
    ON fact_r_c.ReferralGKey = dim_r.ReferralGKey
)

SELECT
    *
FROM
    final