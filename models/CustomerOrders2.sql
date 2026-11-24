{{ config(materialized='table', schema='Retail', persist_docs={'relation': true, 'columns': true},
    partition_by={ 'field':'DateTime', 'data_type':'DateTime', 'granularity':'day'},
    require_partition_filter='true', alias='CustomerOrdersUseMacro',
    pre_hook=["INSERT INTO {{ source('Retail', 'AuditMetadata') }} VALUES ('CustomerOrders2', 'Running', current_datetime(), null)"],
    post_hook=["UPDATE {{ source('Retail', 'AuditMetadata') }}  AS Source
                SET Source.ModelState = 'Completed', Source.EndDateTime = current_datetime
                FROM (SELECT ModelName, StartDateTime, ROW_NUMBER() OVER (Partition by ModelName order by StartDateTime DESC)
                        FROM {{ source('Retail', 'AuditMetadata') }}
                        WHERE ModelName = 'CustomerOrders2'
                        QUALIFY  ROW_NUMBER() OVER (Partition by ModelName order by StartDateTime DESC) = 1 ) AS Row1
                WHERE source.ModelName = Row1.ModelName
                 AND source.StartDateTime = Row1.StartDateTime"]


                                        
    ) }}

select  Customers.customer_id, Orders.OrderID, Orders.Quantity, Orders.Status, Orders.DateTime, Customers.country
        {# thsi is a
         comment #}
        , {{ generatefullname('first_name', 'last_name') }} AS FullName 
        , {{ CountryIsUSA('country') }} AS IsUnitedStates

from    {{ source('Retail', 'Customers') }} Customers
    INNER JOIN {{ source('Retail', 'Orders') }} Orders On Customers.customer_id = Orders.CustomerID