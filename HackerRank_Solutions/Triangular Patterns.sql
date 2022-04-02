 /*1.) P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* * * * * 
* * * * 
* * * 
* * 
*
Write a query to print the pattern P(20). */


;WITH CTE
AS
(

SELECT 20 AS N
UNION ALL
SELECT N-1 FROM CTE WHERE N>0
)

SELECT REPLICATE('* ',N) FROM CTE

 /* 
 2.) P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* 
* * 
* * * 
* * * * 
* * * * *
Write a query to print the pattern P(20). */

DECLARE @I INT 
SET @I=1

WHILE @I<=20
BEGIN

SELECT REPLICATE('* ',@I)


SET @I=@I+1


END
