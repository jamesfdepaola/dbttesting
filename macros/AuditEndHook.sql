
{% macro AuditEndHook() -%}
    UPDATE {{ source('Retail', 'AuditMetadata') }} 
    SET ModelState = 'Completed', EndDateTime = current_datetime                
    WHERE InvocationID = '{{ invocation_id }}'
{%- endmacro -%}