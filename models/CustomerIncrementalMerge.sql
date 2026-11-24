{{ config(materialized='incremental', schema='Retail', 
        persist_docs={'relation': true, 'columns': true}, 
        incremental_strategy='merge', unique_key=['customer_id', 'email']) }}

select  Customers.*
from    {{ source('Retail', 'Customers') }} Customers
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where created_at > (select max(created_at) from {{ this }}) 
{% endif %}

