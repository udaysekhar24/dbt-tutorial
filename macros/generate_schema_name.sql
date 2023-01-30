{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- set target_name = target.name -%}

    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- elif  target_name == 'prod' -%}

        {{ custom_schema_name | trim }}

    {%- else -%}

        {{ target_name }}_{{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}