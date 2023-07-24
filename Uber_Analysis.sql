/*Write a query to find total rides and profit rides by each driver.

Profit ride is when the end location of the current ride is the same as the start location of the next ride.

It is not necessary that the end time of the current ride should be the same as the start time of the next ride to qualify as a profit ride.

Bonus point if you solve it without using lead and lag functions.

*/

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));

insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

SELECT * FROM drivers
;WITH CTE AS 
(
SELECT *,ROW_NUMBER() over(partition by id order by start_time) as rid
FROM drivers
)
SELECT  a.ID,COUNT(A.ID) as tot_rides,count(b.id) as profit_rides
FROM CTE A
LEFT JOIN CTE B
on a.rid+1=b.rid
and a.id=b.id
and a.end_loc=b.start_loc
group by a.ID