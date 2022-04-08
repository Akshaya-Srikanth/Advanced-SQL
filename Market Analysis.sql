/*
WRITE A QUERY TO FIND THE SECOND ITEM SOLD BY EACH SELLER AND SEE IF IT'S SAME AS THEIR 
FAV BRAND IF YES RETURN YES OR NO
IF THE SELLER HAS SOLD LESS THAN TWO ITEMS THEN ALSO RETURN NO
*/

DROP TABLE IF EXISTS users
create table users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));
 GO
 DROP TABLE IF EXISTS orders
 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );
 GO
  DROP TABLE IF EXISTS ITEMS
 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );
 GO

 insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);

 SELECT * FROM USERS
 
 SELECT * FROM ITEMS
 
 SELECT * FROM ORDERS

WITH SELLER_CTE AS (
SELECT U.user_id,ORDER_DATE,I.ITEM_BRAND,
ROW_NUMBER() OVER(PARTITION BY  SELLER_ID ORDER BY ORDER_DATE  )  AS RNO
,U.favorite_brand
FROM  USERS U
LEFT  JOIN ORDERS O
ON U.user_id=O.seller_id
LEFT  JOIN ITEMS I
ON I.ITEM_ID=O.ITEM_ID

 )
SELECT user_id AS SELLER_ID,CASE WHEN ITEM_BRAND=favorite_brand then 'YES' ELSE 'NO' END  AS ITEM_FAV_BRAND
FROM SELLER_CTE  
WHERE RNO=2 OR ITEM_BRAND IS NULL


