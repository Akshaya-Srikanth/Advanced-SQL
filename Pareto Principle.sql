/*Find out top 20 % products which gives 80% of the sales.This is also known as Pareto principle
*/
--80% of Sales
select sum(sales)*0.8 
from  [dbo].[Orders]
--1837760.68823996
;WITH product_wise_sales as(
select product_id,sum(sales) as product_sales
from [dbo].[Orders]
group by product_id
),
sales_runningtot as (
select product_id,product_sales
,sum(product_sales) over(order by product_sales desc rows between unbounded preceding and 0 preceding) as running_total
,0.8*sum(product_sales) over() as total_sales
from product_wise_sales
)

select * from sales_runningtot where running_total <=total_sales




