{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none or custom_schema_name == '' -%}
        {{ target.schema | upper }}          {# fall back to env schema e.g. DBTDEV #}
    {%- else -%}
        {{ custom_schema_name | upper }}     {# use exactly the custom schema #}
    {%- endif -%}
{%- endmacro %}
