SELECT  TOP 5 * FROM [HumanResources].[Employee] as Employee
FOR XML AUTO,ELEMENTS,ROOT('Employees')

DECLARE @XMLData xml= (SELECT  TOP 5 * FROM [HumanResources].[Employee] as Employee
FOR XML AUTO,ELEMENTS,ROOT('Employees'))


SELECT LoginID=@XMLData.value('Employees[1]/Employee[1]/LoginID[1]','Varchar(50)')
,HireDate=@XMLData.value('Employees[1]/Employee[1]/HireDate[1]','Varchar(50)')


SELECT LoginID=@XMLData.value('Employees[1]/Employee[5]/LoginID[1]','Varchar(50)')
,HireDate=@XMLData.value('Employees[1]/Employee[5]/HireDate[1]','Varchar(50)')

--TO Pull All Employees

DECLARE @AllXMLData xml= (SELECT   * FROM [HumanResources].[Employee] as Employee
FOR XML AUTO,ELEMENTS,ROOT('Employees'))

SELECT  LoginID=Emp.row.value('LoginID[1]','varchar(50)')
,HireDate= Emp.row.value('HireDate[1]','varchar(50)')
 FROM @AllXMLData.nodes('Employees/Employee') Emp(row)


 -- GEN XML USING EXPLICIT

SELECT   1 as Tag,NULL as PARENT, 
HireDate as [MyEmp!1!HireDate],
JobTitle as [MyEmp!1!JobTitle]
,SalariedFlag as [MyEmp!1!SalariedFlag]
FROM [HumanResources].[Employee] as Employee
FOR XML EXPLICIT -- THis outputs as an attribute
--Customizing 

--To output as Elements

SELECT   1 as Tag,NULL as PARENT, 
HireDate as [MyEmp!1!HireDate!ELEMENT],
JobTitle as [MyEmp!1!JobTitle!ELEMENT]
,SalariedFlag as [MyEmp!1!SalariedFlag!ELEMENT]
FROM [HumanResources].[Employee] as Employee
FOR XML EXPLICIT 


-- Adding Root ELement
SELECT   1 as Tag,NULL as PARENT, 
HireDate as [MyEmp!1!HireDate!ELEMENT],
JobTitle as [MyEmp!1!JobTitle!ELEMENT]
,SalariedFlag as [MyEmp!1!SalariedFlag!ELEMENT]
FROM [HumanResources].[Employee] as Employee
FOR XML EXPLICIT ,ROOT('Employees') 

/********************************************************************************************
USING XML PATH
*************************************************************************************/
SELECT *
FROM [HumanResources].[Employee] 
FOR XML PATH('Employee'),root('Employees')

---Customizing XML

SELECT BusinessEntityID "@BusinessEntityID" -- Will be Displayed as an attribute
,LoginID
,OrganizationNode
,OrganizationLevel
,JobTitle "Designation"
,BirthDate  "PersonalDetails/DOB" --Grouping Similar Data under a common tag
,MaritalStatus "PersonalDetails/MaritalStatus" --Grouping Similar Data under a common tag
,Gender "PersonalDetails/MaritalStatus"--Grouping Similar Data under a common tag
,NationalIDNumber "PersonalDetails/NationalIDNumber" --Grouping Similar Data under a common tag
,HireDate
,SalariedFlag
,VacationHours
,SickLeaveHours
,CurrentFlag
,rowguid
,ModifiedDate
FROM [HumanResources].[Employee] 
FOR XML PATH('Employee'),root('Employees')


