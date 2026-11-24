{{ config(materialized='table', schema='Retail', persist_docs={'relation': true, 'columns': true}) }}

select  *
from    {{ ref('CustomersEphemeral') }} CustomersByCountry