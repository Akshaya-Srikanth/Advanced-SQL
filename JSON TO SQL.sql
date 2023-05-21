DECLARE @JsonData  Varchar(max)
='{
"Employees": [
{"EmpID":1,"EmpName":"Vincenzo"},
{"EmpID":2,"EmpName":"Kitty"},
{"EmpID":3,"EmpName":"Yuri"},
{"EmpID":4,"EmpName":"Dae"},
{"EmpID":5,"EmpName":"Cha Young"}
	]
}';

--Read a specific row 
SELECT  EmpID=JSON_VALUE(@JsonData,'$.Employees[0].EmpID')
,EmpName=JSON_VALUE(@JsonData,'$.Employees[0].EmpName')

--To read all rows

SELECT *
from OPENJSON(@JsonData,'$.Employees')

--To read all rows in correct column format
SELECT EmpID=JSON_VALUE(value,'$.EmpID')
,EmpName=JSON_VALUE(value,'$.EmpName')
from OPENJSON(@JsonData,'$.Employees')

/* JSON VALUE TYPES:
1 = STRING
2 = NUMBER
3 = BOOLEAN
4 = ARRAY
5 = OBJECT
*/

DECLARE @JSONDataTypes VARCHAR(MAX)=
'{
"string":"this is a string data",
"number":4,
"boolean":true,
"array" :["Peter","Parker"],
"object": {
	"name" : "this is an object data" }
}'

select * from OPENJSON(@JSONDataTypes)

--PATH MODES

--LAX(DEFAULT) =RETURNS BLANK IF PATH RETURNS ERROR
--STRICT =RETURNS ERROR IF PATH CONTAINS ERROR

-- IN THIS QUERY SINCE ITS USING DEFAULT LAX MODE IT RETURNS NULL FOR EMPID SINCE THE PATH SPECIFIED ISNT ACCURATE owing to the case sensitivity of the path name
SELECT  EmpID=JSON_VALUE(@JsonData,'$.Employees[0].empid')
,EmpName=JSON_VALUE(@JsonData,'$.Employees[0].EmpName')

--example of above query in strict mode : This throws error since the path specified is not in the JSON PAYLOAD
BEGIN TRY

SELECT  EmpID=JSON_VALUE(@JsonData,' strict $.Employees[0].empid')
,EmpName=JSON_VALUE(@JsonData,'strict $.Employees[0].EmpName')

END TRY
BEGIN CATCH
SELECT  ERROR_MESSAGE() as [Error Message],ERROR_LINE() as 'Errored Line'
END CATCH 