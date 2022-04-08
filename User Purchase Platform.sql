/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/

DROP TABLE IF EXISTS SPENDING 
create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

GO

SELECT * FROM spending

/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/

;WITH Purchases as
(
SELECT spend_date,user_id,max(platform) as platform ,sum(amount) as amount
FROM spending
GROUP BY spend_date,user_id
having count(distinct platform)=1
union all
SELECT spend_date,user_id,'both' as platform ,sum(amount) as amount
FROM spending
GROUP BY spend_date,user_id
having count(distinct platform)=2
union
SELECT spend_date,null as user_id,'both' as platform ,0 as amount
FROM spending
GROUP BY spend_date,user_id
)

select spend_date, platform ,sum(amount) as totalamount ,count(distinct user_id) as total_users
from Purchases
group by spend_date,platform
order by spend_date