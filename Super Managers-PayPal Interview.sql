--Super Managers: PayPal
/*Find managers with at least 7 direct reporting employees.
Output first names of managers.*/

-- 1ST APPROACH
select m.first_name
from employee e
inner join employee m
on e.manager_id=m.id
group by m.first_name
having count(distinct e.id )>=7

--2ND APPROACH

SELECT first_name
FROM EMPLOYEE E
JOIN ( SELECT MANAGER_ID FROM EMPLOYEE 
where MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING COUNT(*)>=7
)A
ON A.MANAGER_ID=E.ID

--3RD APPROACH
SELECT  FIRST_NAME
FROM EMPLOYEE WHERE ID IN (
SELECT MANAGER_ID
FROM
(SELECT MANAGER_ID,COUNT(1) AS CNT
 FROM EMPLOYEE 
 where MANAGER_ID IS NOT NULL
GROUP BY 1
)A
WHERE A.CNT>=7
)