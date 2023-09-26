/*Problem Statement -
There is a Position Table that Contains Job Vacancies that are available and a Employee table that contains Employees Who have Already Applied . Using these Two Table Scripts you have to give the Output same as Share Below .

Script -*/

drop table job_positions;
create table job_positions
(
id int,
title varchar(100),
groups varchar(10),
levels varchar(10),
payscale int,
totalpost int
);
insert into job_positions values (1, 'General manager', 'A', 'l-15', 10000, 1);
insert into job_positions values (2, 'Manager', 'B', 'l-14', 9000, 5);
insert into job_positions values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10);

drop table if exists job_employees;
create table job_employees
(
id int,
name varchar(100),
position_id int
);
insert into job_employees values (1, 'John Smith', 1);
insert into job_employees values (2, 'Jane Doe', 2);
insert into job_employees values (3, 'Michael Brown', 2);
insert into job_employees values (4, 'Emily Johnson', 2);
insert into job_employees values (5, 'William Lee', 3);
insert into job_employees values (6, 'Jessica Clark', 3);
insert into job_employees values (7, 'Christopher Harris', 3);
insert into job_employees values (8, 'Olivia Wilson', 3);
insert into job_employees values (9, 'Daniel Martinez', 3);
insert into job_employees values (10, 'Sophia Miller', 3);

select * from job_positions;
select * from job_employees;

WITH CTE_POS
AS
(
select JP.ID,JP.title,JP.groups,JP.levels,JP.payscale,totalpost as pos
FROM job_positions JP
UNION ALL

SELECT ID, title,groups,levels,payscale,POS-1 
FROM CTE_POS
WHERE POS>1
) ,
CTE_Emp as
(
select id,name,position_id,ROW_NUMBER() OVER(Partition by position_id order by id) as RN
from job_employees
)

SELECT title,groups,levels,payscale,COALESCE(name,'Vacant') as EmployeeName--,rn,pos
FROM CTE_POS CP
LEFT JOIN CTE_Emp  CE
ON CP.id=CE.position_id
AND POS=RN --will retrieve names of employees which match with the pos index hence the vacant ones will be null
order by groups,pos