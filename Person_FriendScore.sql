/*
Write a query to find PersonID,name,noof friends,
sum of marks of the person whose friends have their total score greater than 100
*/

select * from Person
select * from Friend
WITH FRIENDSCORE 
AS(
SELECT F.PERSONID,COUNT(1) AS NO_OFFRIENDS,SUM(SCORE) AS TOTAL_SCORE
FROM PERSON P
JOIN FRIEND F 
ON F.FRIENDID=P.PERSONID
GROUP BY F.PERSONID
HAVING SUM(SCORE)>100
)

SELECT P.NAME,FS.* FROM 
FRIENDSCORE FS
JOIN PERSON P
ON FS.PERSONID=P.PERSONID
