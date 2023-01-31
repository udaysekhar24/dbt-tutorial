{{ config(materialized='ephemeral') }}

WITH dummy AS (
    SELECT 1
)

SELECT * FROM dummy