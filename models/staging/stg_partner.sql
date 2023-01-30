{{ config(
    materialized='table',
    tags=["daily"]
) }}

WITH import_partner AS (
    SELECT 
        *
    FROM
        {{ source('seed_data', 'partners') }}
    -- Filter if sales person is not valid value in PROD. 
    {% if target.name == "prod" %} 
    WHERE
        lead_sales_contact != '0'
    {% endif %}
)

SELECT 
    * EXCEPT(created_at, updated_at),
    -- Convert UNIX Nano to Micro secs
    {{ unix_nano_to_timestamp('created_at') }} AS created_at,
    {{ unix_nano_to_timestamp('updated_at') }} AS updated_at
FROM 
    import_partner

