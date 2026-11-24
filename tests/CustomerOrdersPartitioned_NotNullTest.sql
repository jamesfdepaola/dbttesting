/*
    this is the fail condition

    tests are linked  by the ref keyword, not by file name
*/
SELECT CustomerOrders.customer_id
FROM {{ ref("CustomerOrdersPartitioned") }}  CustomerOrders
WHERE  customer_id is null
    AND CustomerOrders.DateTime Between '1900-01-01' and '9999-12-31'