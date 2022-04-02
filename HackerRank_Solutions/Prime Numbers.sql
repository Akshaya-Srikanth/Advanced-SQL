
/*Write a query to print all prime numbers less than or equal to . Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).

For example, the output for all prime numbers  would be:

2&3&5&7
*/

DECLARE @PRIMECHAR NVARCHAR(1000) 

;WITH Prim AS
(
    SELECT 2 AS Value 
    UNION ALL
    SELECT t.Value+1 AS VAlue 
    FROM Prim t
    WHERE t.Value < 1000
)


SELECT @PRIMECHAR=COALESCE(@PRIMECHAR + '&', '') + CAST(VALUE AS VARCHAR(10))
FROM Prim t
WHERE NOT EXISTS(   SELECT 1 FROM prim t2
                WHERE T.Value>t2.Value AND 
                t.Value % t2.Value = 0 
               )
OPTION (MAXRECURSION 0)

SELECT @PRIMECHAR