--WRITE A QUERY TO  GET 3 CONSECUTIVE EMPTY SEATS
DROP TABLE IF EXISTS BMS;

create table bms (seat_no int ,is_empty varchar(10));
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');

SELECT * FROM BMS

--APPROACH 1 : USING LEAD/LAG FUNC
;WITH SEAT_INFO AS (
SELECT SEAT_NO,is_empty AS CURRENT_1
,LAG(IS_EMPTY,1) OVER(ORDER BY SEAT_NO) AS PREV_1
,LAG(IS_EMPTY,2) OVER(ORDER BY SEAT_NO) AS PREV_2
,LEAD(IS_EMPTY,1) OVER(ORDER BY SEAT_NO) AS NEXT_1
,LEAD(IS_EMPTY,2) OVER(ORDER BY SEAT_NO) AS NEXT_2
FROM BMS
)
SELECT * 
FROM SEAT_INFO
WHERE (CURRENT_1='Y' AND PREV_1='Y'AND PREV_2='Y')
OR (CURRENT_1='Y' AND PREV_1='Y'AND NEXT_1='Y')
OR (CURRENT_1='Y' AND NEXT_1='Y'AND NEXT_2='Y')

--APPROACH 2: ADVANCE AGGREGATION
SELECT * FROM
(SELECT SEAT_NO,is_empty, 
SUM(CASE WHEN is_empty='Y' THEN 1 ELSE 0 END ) OVER(ORDER BY SEAT_NO ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS PREV1_2_CURRENT
,SUM(CASE WHEN is_empty='Y' THEN 1 ELSE 0 END ) OVER(ORDER BY SEAT_NO ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS PREV1_CURRENT_NEXT1
,SUM(CASE WHEN is_empty='Y' THEN 1 ELSE 0 END ) OVER(ORDER BY SEAT_NO ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS CURRENT_NEXT1_2
FROM BMS)A
WHERE A.CURRENT_NEXT1_2=3 OR A.PREV1_2_CURRENT=3 OR A.PREV1_CURRENT_NEXT1=3


--APPROACH 3: Using ROW_NUMBER
;WITH CONDIFF AS (
SELECT * ,seat_no-RN AS DIF
FROM
(SELECT *,ROW_NUMBER() OVER(ORDER BY SEAT_NO) AS RN
FROM BMS
WHERE is_empty='Y')A
)
,DIFSELECT AS (
SELECT DIF,COUNT(1) AS CNT 
FROM CONDIFF
GROUP BY DIF
HAVING COUNT(1)>=3
)


SELECT * FROM CONDIFF
WHERE DIF IN ( SELECT DIF FROM DIFSELECT)