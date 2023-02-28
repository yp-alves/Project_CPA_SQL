/* 
Question 2: How should we tailor marketing and communication strategies to customer behaviors?

Categorizing customers:
VIP (very important person) customers and those who are less engaged.

Vamos fazer uam analise de quanto lucro cada cliente proporcionou */

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
				 
/* A partir dessa CTE podemos determinar os 5 clientes que mais deram lucro, sendo os eles os VIPs. E analogamente,
invertendo a ordem podemos descobrir o 5 clientes que menos deram lucro. */

SELECT contactLastName, contactFirstName, city, country
  FROM customers AS c
  JOIN client_profit AS cp
    ON c.customerNumber = cp.customerNumber
 ORDER BY cp.profit DESC 
 LIMIT 5;