drop table if exists customer_orders
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;
select * from customer_orders

-- Find NO OF repeat and new customers per day
;WITH INITIAL_PURCHASE AS 
(
SELECT customer_id,MIN(order_date) AS FIRST_ORDERDATE
FROM customer_orders
GROUP BY customer_id
)

SELECT CO.ORDER_DATE
,SUM(CASE WHEN FIRST_ORDERDATE=order_date THEN 1 ELSE 0 END ) AS NEW_CUSTOMER
,SUM(CASE WHEN FIRST_ORDERDATE<>order_date THEN 1 ELSE 0 END ) AS REPEAT_CUSTOMER
FROM customer_orders CO 
JOIN INITIAL_PURCHASE IP
ON IP.customer_id=CO.customer_id
GROUP BY CO.ORDER_DATE
