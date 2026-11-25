
{% macro AuditStartHook() -%}
    INSERT INTO {{ source('Retail', 'AuditMetadata') }} 
    VALUES ('{{ this.name }}', 'Running', current_datetime(), null, '{{ invocation_id }}' )
{% endmacro -%}