/********************************************
BULK LOAD JSON DATA into SQL Table
********************************************/


--SELECT * FROM
--OPENROWSET(
--BULK 'C:\Users\srich\OneDrive\Documents\SQL Server Management Studio\SampleJSON Data.json' ,SINGLE_CLOB
--) as source_data

DECLARE @Json_Data VARCHAR(Max);

SELECT @Json_Data=BulkColumn
FROM
OPENROWSET(
BULK 'C:\Users\srich\OneDrive\Documents\SQL Server Management Studio\SampleJSON Data.json' ,SINGLE_CLOB
) as source_data

PRINT @Json_Data 

DROP TABLE IF EXISTS #Employee
SELECT  id,name,email
,JSON_VALUE(address,'$.street') as street
,JSON_VALUE(address,'$.city') as city
,JSON_VALUE(address,'$.state') as state
,JSON_VALUE(address,'$.zipcode') as zipcode
,value as phone
,active
into #Employee
FROM OPENJSON (@Json_Data)
WITH
( 
id varchar(20),
name varchar(20),
email varchar(20),
address nvarchar(max)  AS JSON ,
phone_numbers nvarchar(max) AS JSON,
active varchar(20)
)
CROSS APPLY OPENJSON(phone_numbers)

SELECT * FROM #Employee




