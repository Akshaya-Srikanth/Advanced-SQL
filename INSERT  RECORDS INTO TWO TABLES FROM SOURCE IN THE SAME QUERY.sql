--INSERT  RECORDS INTO TWO TABLES FROM SOURCE IN THE SAME QUERY
DROP TABLE IF EXISTS SOURCETBL
CREATE TABLE SOURCETBL
(
 ID INT,
 NAME VARCHAR(100),
 ORGNAME VARCHAR(50)
)
DROP TABLE IF EXISTS USERTEMP

CREATE TABLE USERTEMP
(
 ID INT,
 NAME VARCHAR(100),
 ORGNAME VARCHAR(50)
)

DROP TABLE IF EXISTS USERTEMP_AUDIT
CREATE TABLE USERTEMP_AUDIT
(
 ID INT,
 NAME VARCHAR(100),
 ORGNAME VARCHAR(50),
 
)
INSERT INTO SOURCETBL VALUES (1,'JOHN SMITH','SS UNITECH'),(2,'JOANNE SAWYER','SS UNITECH'),
       (3,'HOWARD FITE','TEMP'),(4,'VIC','TEMP'),(5,'SAM','TEST')


 INSERT INTO  USERTEMP
 OUTPUT INSERTED.ID,INSERTED.NAME,INSERTED.ORGNAME INTO USERTEMP_AUDIT
SELECT * FROM SOURCETBL

GO

SELECT * FROM USERTEMP

SELECT * FROM USERTEMP_AUDIT



