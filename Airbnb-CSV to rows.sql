/*SQL problem asked in Airbnb interview. The problem is called as Most Popular Room Types.  In this problem we will learn how to convert comma separated values into row.
*/

DROP TABLE IF EXISTS airbnb_searches;
create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);

insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')

GO

SELECT * FROM airbnb_searches

SELECT VALUE AS ROOMTYPE,COUNT(1) AS [NO OF SEARCHES]
FROM airbnb_searches
CROSS APPLY string_split(filter_room_types,',')
GROUP BY VALUE
ORDER BY [NO OF SEARCHES] DESC

