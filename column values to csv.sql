drop table if exists  Comma_Separated_Tbl
Create Table Comma_Separated_Tbl
(
   TrainingId Int ,
   Training     varchar(100),
   Classroom    varchar(100),
   StartTime    Time,
   duration     numeric(14,2),
   wk           varchar(10)
)

Insert Comma_Separated_Tbl
Select 1,'SQL Server','Silver Room','10:00',2.00,'M'
Union
Select 2,'SQL Server','Silver Room','10:00',2.00,'W'
UNION
Select 3,'SQL Server','Silver Room','10:00',2.00,'T'
Union
Select 4,'SQL Server','Silver Room','10:00',2.00,'F'
UNION
Select 5,'MSBI','GOLD Room','11:00',1.45,'F'
Union
Select 6,'MSBI','GOLD Room','11:00',1.45,'M'
Union
Select 7,'MSBI','GOLD Room','11:00',1.45,'TH'

select * from Comma_Separated_Tbl

-- APPROACH 1: USING STRING_AGG() FUNC

select Training,Classroom,StartTime,duration,STRING_AGG(WK,',') WITHIN GROUP (ORDER BY STARTTIME ASC) AS WK 
from Comma_Separated_Tbl
GROUP BY  Training,Classroom,StartTime,duration
ORDER BY StartTime


--SELECT STUFF((SELECT ','+WK FROM Comma_Separated_Tbl FOR XML PATH('')),1,1,'')

--APPROACH 2: USING FOR XML PATH
SELECT C.*
FROM
(
SELECT DISTINCT Training,Classroom,StartTime,duration,
(SELECT STUFF((SELECT ','+WK FROM Comma_Separated_Tbl  A WHERE A.Training=B.Training FOR XML PATH('')),1,1,'')) AS WK
FROM Comma_Separated_Tbl B
)AS C
ORDER BY  C.StartTime