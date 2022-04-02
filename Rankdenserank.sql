--windows functions 
--Row_number(),Rank(),Dense_rank(),Ntile()

select * from tblEmployee

--select * from tblEmployee

--update tblEmployee set Salary=3100 where Id=2

--ROw number()
-- SQL Server ROW_NUMBER Syntax
--SELECT ROW_NUMBER() OVER (PARTITION_BY_Clause ORDER_BY_Clause)
--FROM [Source]

select *,row_number() over( order by Salary )'rn' from tblEmployee
select *,row_number() over( partition by name  order by Salary desc)'rn' from tblEmployee


--Rank()
--SELECT RANK() OVER (PARTITION_BY_Clause ORDER_BY_Clause) FROM [Source]

select *,RANK() over( partition by Gender order by Salary asc)'rn' from tblEmployee

--Dense_rank
select *,Dense_RANK() over( partition by Gender order by Salary asc)'rn' from tblEmployee

--ntile

--SELECT NTILE(Interger_Value) OVER (PARTITION_BY_Clause ORDER_BY_Clause)
--FROM [Source]

select *,NTILE(4) over(partition by Gender order by Salary asc)'rn' from tblEmployee


select *,NTILE(5) over(partition by Gender order by Salary asc)'rn',Dense_RANK() over( partition by Gender order by Salary asc)'rn1' from tblEmployee