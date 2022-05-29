/*LeetCode problem where we need to pivot the data from row to column. 
The interesting part about this problem is we don't have a common key to pivot the data on.*/

--Script:

DROP TABLE IF EXISTS players_location
create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

SELECT * FROM players_location -- I/P


--O/P
SELECT MAX(CASE WHEN CITY='Bangalore' THEN NAME END) AS Bangalore
,MAX(CASE WHEN CITY='Mumbai' THEN NAME END) AS Mumbai
,ISNULL(MAX(CASE WHEN CITY='Delhi' THEN NAME END),'No Player') AS Delhi
FROM
(
SELECT * ,ROW_NUMBER() OVER(PARTITION BY CITY ORDER BY NAME) AS GROUP_KEY
FROM players_location
) A
GROUP BY A.GROUP_KEY







