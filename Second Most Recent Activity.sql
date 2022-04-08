/*Find second most recent activity and if user has only 1 activity then return that as it is. 
Use SQL window functions to solve this problem.*/

DROP TABLE  IF EXISTS USERACTIVITY
CREATE TABLE USERACTIVITY
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

INSERT INTO USERACTIVITY VALUES 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');

SELECT * FROM USERACTIVITY

;WITH SECONDACTIVITY AS (
SELECT * ,COUNT(1) OVER( PARTITION BY USERNAME ) AS TOTAL_ACTIVITIES
,DENSE_RANK() OVER(PARTITION BY USERNAME ORDER BY STARTDATE DESC) AS RNK
FROM USERACTIVITY
)
SELECT * FROM SECONDACTIVITY WHERE RNK=2 OR TOTAL_ACTIVITIES=1
