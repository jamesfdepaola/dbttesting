
{% macro AuditFailHook(results) -%}
    {% for result in results -%}
        {% if result.node.resource_type == 'model' and result.status == 'error' -%}
            {% set model_name = result.node.name -%}
            {% set error_message = result.message -%}
            {% set audit_sql -%}
                UPDATE {{ source('Retail', 'AuditMetadata') }}  
                SET ModelState = 'Failed', 
                    EndDateTime = current_datetime                
                WHERE InvocationID = '{{ invocation_id }}'
                    
            {% endset -%}
            {% do run_query(audit_sql) -%}
        {% endif -%}
    {% endfor -%}
{%- endmacro %}