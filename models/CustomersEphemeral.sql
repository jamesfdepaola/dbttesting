{{ config(materialized='ephemeral', schema='Retail', 
        persist_docs={'relation': true, 'columns': true}) }}

select  COUNT(customer_id) AS CountryCustomers,
        country
from    {{ source('Retail', 'Customers') }} Customers
GROUP BY 
        country