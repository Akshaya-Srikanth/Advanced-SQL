-- Find the total number of messages exchanged b/w each person per day

DROP TABLE IF EXISTS SUBSCRIBER
CREATE TABLE subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
-- insert some values
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);
go

select * from subscriber


---OUTPUT


SELECT SMS_DATE,P1,P2,SUM(SMS_NO) AS TOTAL_MESSAGES
FROM
(SELECT sms_date,
CASE WHEN SENDER<RECEIVER THEN SENDER ELSE RECEIVER END AS P1
,CASE WHEN SENDER>RECEIVER THEN SENDER ELSE RECEIVER END AS P2
,sms_no
FROM subscriber
) A
GROUP BY SMS_DATE,P1,P2
