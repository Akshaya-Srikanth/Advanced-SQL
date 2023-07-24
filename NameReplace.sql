SELECT 1+ 'A'
SELECT CONCAT(1,'A')

CREATE OR ALTER FUNCTION replace__name_first_letter(@NAME NVARCHAR(50))
RETURNS NVARCHAR(50)
BEGIN
--Assumption is there would be a space seperating First and Last Names
DECLARE @FirstName NVARCHAR(20) = LEFT(@Name,CHARINDEX(SPACE(1),@Name))
,@LastName  NVARCHAR(20) =SUBSTRING(@Name,CHARINDEX(SPACE(1),@Name)+1,LEN(@Name))
,@Result NVARCHAR(50);

SELECT @Result=CONCAT_WS( SPACE(1),STUFF(@FirstName,1,1,LEFT(@LastName,1)) ,STUFF(@LastName,1,1,LEFT(@FirstName,1)))

RETURN @Result
END


DECLARE @Name NVARCHAR(50)= 'Akshaya Srikanth'

select [dbo].[replace__name_first_letter] ( @Name)

CREATE TABLE Employee (
  EmployeeName VARCHAR(255) NOT NULL,
  ID INT NOT NULL,
  PRIMARY KEY (ID)
);

-- Insert data into the Employee table
INSERT INTO Employee (EmployeeName, ID) VALUES
  ('John Doe', 1),
  ('Jane Smith', 2),
  ('Bob Johnson', 3);



  select *,[dbo].[replace__name_first_letter](EmployeeName) AS ModifiedName
  FROM Employee
  