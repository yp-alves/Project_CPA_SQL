/*
To determine how much money we can spend acquiring new customers, we can compute the Customer Lifetime Value (LTV), 
which represents the average amount of money a customer generates. We can then determine how much we can spend 
on marketing.
*/

WITH 
client_profit AS (
SELECT o.customerNumber,
	   SUM(quantityOrdered*(priceEach-buyPrice)) AS profit
  FROM orders AS o
  JOIN orderdetails AS od
    ON o.orderNumber = od.orderNumber
  JOIN products p
    ON od.productCode = p.productCode
 GROUP BY o.customerNumber
				 )
				 
SELECT AVG(profit) AS LVT
  FROM client_profit