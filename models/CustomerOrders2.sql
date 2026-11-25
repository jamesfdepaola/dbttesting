{{ config(materialized='table', schema='Retail', persist_docs={'relation': true, 'columns': true},
    partition_by={ 'field':'DateTime', 'data_type':'DateTime', 'granularity':'day'},
    require_partition_filter='true', alias='CustomerOrdersUseMacro',
    pre_hook= "{{ AuditStartHook() }}",
    post_hook="{{ AuditEndHook() }}"


                                        
    ) }}

select  Customers.customer_id, Orders.OrgderID, Orders.Quantity, Orders.Status, Orders.DateTime, Customers.country
        {# thsi is a
         comment #}
        , {{ generatefullname('first_name', 'last_name') }} AS FullName 
        , {{ CountryIsUSA('country') }} AS IsUnitedStates

from    {{ source('Retail', 'Customers') }} Customers
    INNER JOIN {{ source('Retail', 'Orders') }} Orders On Customers.customer_id = Orders.CustomerID