/*Product recommendation. Just the basic type (“customers who bought this also bought…”). 
That, in its simplest form, is an outcome of basket analysis. 
find products which are most frequently bought together using simple SQL
Based on the history ecommerce website can recommend products to new user.*/
DROP TABLE IF EXISTS orders
create table orders
(
order_id int,
customer_id int,
product_id int
);

insert into orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

DROP TABLE IF EXISTS products
create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

WITH PAIR_PRODUCT AS (
SELECT O1.order_id,O1.product_id AS P1, O2.product_id AS P2
FROM ORDERS O1
JOIN ORDERS O2
ON O1.order_id=O2.order_id)

SELECT  CONCAT(PR1.NAME,',',PR2.NAME) AS PAIR,COUNT(1) AS PURCHASE_FREQUENCY
FROM PAIR_PRODUCT PRP
JOIN products PR1
ON PR1.ID=PRP.P1
JOIN products PR2
ON PR2.ID=PRP.P2
WHERE  P1<P2 
GROUP BY PR1.NAME,PR2.NAME