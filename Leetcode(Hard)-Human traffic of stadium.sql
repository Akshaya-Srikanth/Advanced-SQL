--WAQ TO FETCH 3 OR MORE CONSECUTIVE ROWS WITH NOOFPEOPLE MORE THAN 100 EACH DAY
DROP TABLE IF EXISTS stadium
create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);

GO

SELECT * FROM stadium

--SOLUTION 1
;WITH CTE AS
(SELECT *,ID-ROW_NUMBER() OVER (ORDER BY VISIT_DATE) AS GRP
FROM stadium
WHERE no_of_people>=100
)

SELECT ID,visit_date,no_of_people
FROM CTE
WHERE GRP IN (
SELECT GRP
FROM CTE
GROUP BY GRP
HAVING COUNT(1)>=3)

--SOLUTION 2: WITH LEAD/LAG
SELECT * FROM stadium
