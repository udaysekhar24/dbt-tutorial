{% macro test_is_supported_country(model, column_name) -%}
    {%- set supported_countries="'UK', 'HongKong', 'Singapore'" -%}
    WITH validation AS (
        SELECT
            {{ column_name }} AS col
        FROM
            {{ model }}
    ),

    validation_errors AS (
        SELECT
            col
        FROM
            validation
        WHERE
            col NOT IN ({{ supported_countries }})
    )
    SELECT 
        COUNT(*) AS error_count
    FROM
        validation_errors
{% endmacro %}