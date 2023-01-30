
{% macro unix_nano_to_timestamp(column_name) %}
    TIMESTAMP_MICROS(CAST({{ column_name }}/1000 AS INT64))
{% endmacro %}