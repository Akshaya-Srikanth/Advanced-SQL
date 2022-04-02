--SELECT * FROM  ICC_WORLD_CUP
/*Derive Points table for ICC tournament ,DETERMINING WINS AND LOSES FOR EACH TEAM

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;*/

;WITH CTE AS(
select TEAM_1,WINNER from ICC_WORLD_CUP
UNION ALL
select TEAM_2,WINNER from ICC_WORLD_CUP)

SELECT TEAM_1 AS Team_name,COUNT(TEAM_1) AS [No of matches played]
,SUM(CASE WHEN TEAM_1=WINNER THEN 1 ELSE 0 END)  AS [No of wins]
,COUNT(TEAM_1)-SUM(CASE WHEN TEAM_1=WINNER THEN 1 ELSE 0 END) AS [No of loses]
FROM CTE
GROUP BY TEAM_1
ORDER BY [No of wins] DESC