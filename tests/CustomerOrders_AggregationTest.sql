/*
    this is the fail condition
*/
SELECT SUM(Quantity) AS TotalQuantity
FROM {{ ref("CustomerOrders") }} 
GROUP BY customer_id
HAVING SUM(Quantity) = 0