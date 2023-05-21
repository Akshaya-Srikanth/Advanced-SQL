--CONV SQL ROWS TO JSON
SELECT  *
FROM [Customer DataWarehouse].[dbo].[DimSalesPerson]
FOR JSON PATH

--CUSTOMIZING ELEMENT NAMES
SELECT SalesPersonId AS PersonId,SalesPersonName as PersonName
FROM [Customer DataWarehouse].[dbo].[DimSalesPerson] AS SalesPerson
FOR JSON PATH 

--Adding Root ELement
SELECT SalesPersonId AS PersonId,SalesPersonName as PersonName
FROM [Customer DataWarehouse].[dbo].[DimSalesPerson] AS SalesPerson
FOR JSON PATH ,ROOT('SalesPerson')