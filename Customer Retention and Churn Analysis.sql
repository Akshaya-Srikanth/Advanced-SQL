/*Customer retention refers to the ability of a company or product to retain its customers over some specified period. High customer retention means customers of the product or business tend to return to, continue to buy or in some other way not defect to another product or business, or to non-use entirely. 
Company programs to retain customers: Zomato Pro , Cashbacks, Reward Programs etc.
Once these programs in place we need to build metrics to check if programs are working or not. 
That is where we will write SQL to drive customer retention count.  */

DROP TABLE IF EXISTS transactions
create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);

insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)

SELECT * FROM  transactions;

--CUSTOMER RETENTION EACH MONTH
--JAN 0
--FEB 1,2,3 (CUSTIDS) - COUNT=3


SELECT * FROM  transactions;

WITH CUSTRETENTION AS
(
SELECT *,COUNT(1) OVER(PARTITION BY CUST_ID ORDER BY ORDER_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING) AS RETAINEDCOUNT
FROM transactions
)

SELECT DATENAME(MONTH,ORDER_DATE) AS MONTH,SUM(CASE WHEN RETAINEDCOUNT>1 THEN 1 ELSE 0 END) AS RETAINEDCOUNT
FROM 
CUSTRETENTION
GROUP BY DATENAME(MONTH,ORDER_DATE)
ORDER BY DATENAME(MONTH,ORDER_DATE) DESC


--CUSTOMER CHURN  EACH MONTH
--JAN 0
--FEB 4 (CUSTIDS) - COUNT=1

WITH CUSTCHURN AS
(
SELECT *,COUNT(1) OVER(PARTITION BY CUST_ID ORDER BY ORDER_DATE ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS CHURNCOUNT
FROM transactions
)

SELECT DATENAME(MONTH,ORDER_DATE) AS MONTH,SUM(CASE WHEN CHURNCOUNT>1 THEN 0 ELSE 1 END) AS CHURNCOUNT
FROM 
CUSTCHURN
GROUP BY DATENAME(MONTH,ORDER_DATE)
ORDER BY DATENAME(MONTH,ORDER_DATE) DESC
