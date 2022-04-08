--WAQ TO FIND THE WINNER IN EACH GROUP INCASE THERE IS A TIE GO WITH THE LEAST PLAYER'S ID
DROP TABLE IF EXISTS PLAYERS
create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

DROP TABLE IF EXISTS MATCHES
create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

GO

SELECT * FROM MATCHES
SELECT * FROM players

;WITH PLAYERSCORES AS
(SELECT FIRST_PLAYER  AS PLAYER_ID ,first_score AS SCORE
FROM MATCHES
UNION ALL
SELECT SECOND_PLAYER AS PLAYER_ID,SECOND_SCORE AS SCORE
FROM MATCHES
)
,FINAL_SCORES AS
(
SELECT P.GROUP_ID,PS.PLAYER_ID,SUM(SCORE) AS TOTALSCORE
,DENSE_RANK() OVER(PARTITION BY P.GROUP_ID ORDER BY SUM(SCORE) DESC,PS.PLAYER_ID ) AS RNK
FROM PLAYERSCORES PS
JOIN PLAYERS P 
ON P.PLAYER_ID=PS.PLAYER_ID
GROUP BY PS.PLAYER_ID,P.GROUP_ID)

SELECT GROUP_ID,PLAYER_ID ,TOTALSCORE FROM FINAL_SCORES
WHERE RNK=1
