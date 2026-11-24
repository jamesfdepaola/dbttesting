{{ config(materialized='table', schema='Retail', persist_docs={'relation': true, 'columns': true},
    partition_by={ 'field':'DateTime', 'data_type':'DateTime', 'granularity':'day'},
    require_partition_filter='true'
    ) }}

select  Customers.customer_id, Orders.OrderID, Orders.Quantity, Orders.Status, Orders.DateTime
from    {{ source('Retail', 'Customers') }} Customers
    INNER JOIN {{ source('Retail', 'Orders') }} Orders On Customers.customer_id = Orders.CustomerID