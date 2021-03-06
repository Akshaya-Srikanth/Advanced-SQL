--LeetCode Hard SQL Problem | Employee Median Salary Company Wise
--WAQ to find median salary of employees for each company. 
DROP TABLE IF EXISTS EMPLOYEE
create table employee 
(
emp_id int,
company varchar(10),
salary int
);

insert into employee values (1,'A',2341)
insert into employee values (2,'A',341)
insert into employee values (3,'A',15)
insert into employee values (4,'A',15314)
insert into employee values (5,'A',451)
insert into employee values (6,'A',513)
insert into employee values (7,'B',15)
insert into employee values (8,'B',13)
insert into employee values (9,'B',1154)
insert into employee values (10,'B',1345)
insert into employee values (11,'B',1221)
insert into employee values (12,'B',234)
insert into employee values (13,'C',2345)
insert into employee values (14,'C',2645)
insert into employee values (15,'C',2645)
insert into employee values (16,'C',2652)
insert into employee values (17,'C',65);

--SELECT * FROM employee  --I/P

--O/P
SELECT COMPANY,AVG(SALARY) AS MEDIAN_COMPANY_WISE
FROM

(

SELECT * ,ROW_NUMBER() OVER (PARTITION BY COMPANY ORDER BY SALARY) AS RN
,COUNT(1) OVER(PARTITION BY COMPANY  ) AS CNT
FROM employee 
)A
WHERE RN BETWEEN CNT*1.0/2 AND CNT*1.0/2+1
GROUP BY COMPANY