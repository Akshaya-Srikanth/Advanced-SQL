/*problem statement:

Given the following two tables, return the fraction of users, rounded to two decimal places,
who accessed Amazon music and upgraded to prime membership within the first 30 days of signing up. 
p: REPRESENTS PRIME
*/
DROP TABLE IF EXISTS USERS
create table users
(
user_id integer,
name varchar(20),
join_date date
);
insert into users
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

DROP TABLE IF EXISTS EVENTS
create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));

SELECT * FROM USERS
SELECT * FROM EVENTS

SELECT --U.*,E.TYPE,E.access_date,DATEDIFF(DAY,join_date,access_date) AS NOOFDAYS
COUNT(DISTINCT U.user_id)  AS NOOFUSERS, COUNT(CASE WHEN DATEDIFF(DAY,join_date,access_date)<=30 THEN U.USER_ID END) AS SUBWITHIN30DAYS
,CAST(ROUND(100.0*COUNT(CASE WHEN DATEDIFF(DAY,join_date,access_date)<=30 THEN U.USER_ID END)/COUNT(DISTINCT U.user_id),2) AS NUMERIC(7,2)) AS SUBSCRIPTIONRATE
FROM USERS U
LEFT JOIN EVENTS E
ON U.user_id=E.user_id
AND TYPE='P'
WHERE U.user_id IN (SELECT user_id FROM EVENTS WHERE TYPE='Music')