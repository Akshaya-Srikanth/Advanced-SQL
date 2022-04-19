--QUERY TO FIND COMPANIES THAT HAVE ALTEAST TWO USERS WHO SPEAK BOTH ENGLISH AND GERMAN
DROP TABLE IF EXISTS company_users
create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values 
(1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');

SELECT A.company_id
FROM
(
SELECT company_id,USER_ID
FROM company_users
WHERE language IN ('German','English')
GROUP BY company_id,USER_ID
HAVING COUNT( DISTINCT language)=2
)A
GROUP BY A.company_id
HAVING COUNT(DISTINCT A.user_id)>1

