--How many times a substring occurs in a value?

declare @var varchar(50)='yes,no,yes,no,yes'
,@substring varchar(20)='yes';

SELECT @var,REPLACE(@var,@substring,'')

SELECT (LEN(@var)-LEN(REPLACE(@var,@substring,'')))/LEN(@substring) AS NO_OF_OCCURANCES
