--WRITE A SQL QUERY TO FIND 4 CONSECUTIVE EMPTY SEATS IN A ROW.THERE ARE 3 ROWS WITH 10 SEATS EACH
DROP TABLE IF EXISTS movie
create table movie(
seat varchar(50),occupancy int
);
insert into movie values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);

SELECT * FROM movie

--APPROACH 1:MAX-ADVANCE AGGREGATION
;WITH CTE1 AS
(
SELECT *,LEFT(SEAT,1) AS ROW_ID,CAST(SUBSTRING(SEAT,2,2) AS INT) AS SEAT_NO
FROM movie)
,CTE2 AS
(
SELECT *,
MAX(OCCUPANCY) OVER(PARTITION BY ROW_ID ORDER BY SEAT_NO ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS  [4CONSEC_EMPTYSEATS]
,COUNT(OCCUPANCY) OVER(PARTITION BY ROW_ID ORDER BY SEAT_NO ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS  CNT
FROM CTE1)
,CTE3 AS(

SELECT * FROM CTE2
WHERE CNT=4 AND [4CONSEC_EMPTYSEATS]=0
)

SELECT CTE2.* 
FROM CTE3
JOIN CTE2
ON CTE2.ROW_ID =CTE3.ROW_ID
AND CTE2.SEAT_NO BETWEEN CTE3.SEAT_NO AND CTE3.SEAT_NO+3



