{{ config(materialized='table', schema='Retail') }}

select  *
from    {{ source('Retail', 'Orders') }}