/*

Question 1: Which products should we order more of or less of?
This question refers to inventory reports, including low stock(i.e. product in demand) and product performance. 
This will optimize the supply and the user experience by preventing the best-selling products from going 
out-of-stock.

low stock = the sum of each product ordered divided by the quantity of product in stock.
product performance = the sum of sales per product.

Vamos trabalhar com 2 tabelas: orderdetails e products

*/

WITH
qtd_order AS (
SELECT productCode, SUM(quantityOrdered) AS total_orders
  FROM orderdetails
  GROUP BY productCode  ),
  
performance AS ( 
SELECT productCode
  FROM orderdetails
 GROUP BY productCode
 ORDER BY SUM(quantityOrdered*priceEach) DESC
 LIMIT 10		)
  
SELECT p.productCode, q.total_orders, p.quantityInStock, ROUND(1.0*q.total_orders/p.quantityInStock,2) AS low_stock
  FROM products AS p
  JOIN qtd_order AS q
    ON p.productCode = q.productCode
 WHERE p.productCode IN performance
 ORDER BY low_stock DESC;

/* A partir da tabela acima podemos observar os 10 produtos com melhor performace de venda e que necessitam de
uma restocagem urgente. No caso do primeiro produto temos uma grande demanda e uma baixa oferta.*/