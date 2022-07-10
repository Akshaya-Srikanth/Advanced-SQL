--DELETE AND INSERT IN THE SAME QUERY WITHOUT MERGE
DROP TABLE IF EXISTS UserTemp

Create Table UserTemp
(
 Id Int,
 Name Varchar(100),
 OrgName Varchar(50)

)

DROP TABLE IF EXISTS Error_Log
Create Table Error_Log
(
 Id Int,
 Name Varchar(100),
 OrgName Varchar(50),
 Error_Desc Varchar(1000)

)
Insert Into UserTemp values (1,'John Smith','SS Unitech'),(2,'Joanne Sawyer','SS Unitech'),
       (3,'Howard Fite','Temp'),(4,'Vic','Temp'),(5,'Sam','Test')

SELECT * FROM UserTemp


DELETE UT
OUTPUT DELETED.ID,DELETED.NAME,DELETED.ORGNAME,'INCORRECT ORGINIZATION NAME PLEASE CORRECT AND PROCEED FURTHER' INTO Error_Log
FROM UserTemp UT 
WHERE UT.ORGNAME<>'SS Unitech'

SELECT * FROM UserTemp

SELECT * FROM Error_Log