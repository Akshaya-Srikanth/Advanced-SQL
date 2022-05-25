DROP TABLE IF EXISTS event_status ;
create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');

--INPUT
select * from event_status 

--WRITE A QUERY TO RETRIEVE THE LOG ON AND LOG OFF EVENT TIMES IN CHUNKS AND ALSO DISPLAY THE COUNT OF LOGON'S

;WITH CTE1 AS (
select * ,LAG(STATUS,1,STATUS) OVER(ORDER BY EVENT_TIME) AS PREV_STATUS
from event_status
)
,CTE2 AS (
SELECT *,SUM(CASE WHEN STATUS='ON' AND PREV_STATUS='OFF' THEN 1 ELSE 0 END ) OVER (ORDER BY EVENT_TIME) AS GROUPING_KEY
FROM CTE1
)
SELECT MIN(EVENT_TIME) AS LOGON ,LOGOUT=MAX(EVENT_TIME),COUNT(1)-1 AS LOGONCOUNT
 FROM CTE2
 GROUP BY GROUPING_KEY

