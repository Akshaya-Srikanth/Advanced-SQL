Drop table if exists booking_table
CREATE TABLE booking_table(
   Booking_id       VARCHAR(3) NOT NULL 
  ,Booking_date     date NOT NULL
  ,User_id          VARCHAR(2) NOT NULL
  ,Line_of_business VARCHAR(6) NOT NULL
);
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b1','2022-03-23','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b2','2022-03-27','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b3','2022-03-28','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b4','2022-03-31','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b5','2022-04-02','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b6','2022-04-02','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b7','2022-04-06','u5','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b8','2022-04-06','u6','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b9','2022-04-06','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b10','2022-04-10','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b11','2022-04-12','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b12','2022-04-16','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b13','2022-04-19','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b14','2022-04-20','u5','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b15','2022-04-22','u6','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b16','2022-04-26','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b17','2022-04-28','u2','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b18','2022-04-30','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b19','2022-05-04','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b20','2022-05-06','u1','Flight');
;

Drop table if exists user_table
CREATE TABLE user_table(
   User_id VARCHAR(3) NOT NULL
  ,Segment VARCHAR(2) NOT NULL
);
INSERT INTO user_table(User_id,Segment) VALUES ('u1','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u2','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u3','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u4','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u5','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u6','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u7','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u8','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u9','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u10','s3');

select * from booking_table
select * from user_table

--1. SUMMARY AT Segment Level

select segment,count(DISTINCT UT.User_id) as total_user_count,COUNT(DISTINCT BT.USER_ID) AS USERS_WHO_BOOKED_FLIGHT_APR2022
from user_table UT
LEFT JOIN booking_table BT 
ON BT.User_id=UT.User_id
AND YEAR(BT.Booking_date)=2022
AND MONTH(BT.Booking_date)=4
and bT.Line_of_business= 'Flight'
group by segment

--2. Users whose first booking was hotel booking

--1ST APPROACH: USING SUBQUERY

SELECT DISTINCT User_id
FROM booking_table BT1
WHERE Line_of_business='Hotel'
AND Booking_date =(SELECT MIN(BOOKING_DATE) 
FROM booking_table BT2
WHERE  BT1.User_id=BT2.User_id)

--2ND APPROACH: USING FIRST_VALUE FUNC
;WITH C AS
(
SELECT *,FIRST_VALUE(Line_of_business) OVER (PARTITION BY User_id ORDER BY BOOKING_DATE ) AS FIRST_BOOKING
FROM booking_table
)
SELECT DISTINCT USER_ID FROM C WHERE FIRST_BOOKING='Hotel'



--3.WAQ TO FIND THE NO OF DATES BETWEEN FIRST AND LAST BOOKING OF EACH USER

SELECT User_id,DATEDIFF( DAY,MIN(Booking_date) ,MAX(Booking_date)) AS [NO OF DAYS]
FROM booking_table
GROUP BY User_id

--4. WAQ TOCOUNT NUMBER OF FLIGHT AND HOTEL BOOKINGS IN EACH OF THE USER SEGMENTS IN THE YEAR 2022

select segment,SUM(CASE WHEN  bT.Line_of_business= 'Flight' THEN 1 ELSE 0 END) AS USERS_WHO_BOOKED_FLIGHT_2022
,SUM(CASE WHEN  bT.Line_of_business= 'Hotel' THEN 1 ELSE 0 END) AS USERS_WHO_BOOKED_Hotel_2022
from user_table UT
inner JOIN booking_table BT 
ON BT.User_id=UT.User_id
AND YEAR(BT.Booking_date)=2022
group by segment