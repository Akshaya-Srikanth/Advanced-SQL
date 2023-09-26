create table brands
(
    Year    int,
    Brand   varchar(20),
    Amount  int
);
insert into brands values (2018, 'Apple', 45000);
insert into brands values (2019, 'Apple', 35000);
insert into brands values (2020, 'Apple', 75000);
insert into brands values (2018, 'Samsung', 15000);
insert into brands values (2019, 'Samsung', 20000);
insert into brands values (2020, 'Samsung', 25000);
insert into brands values (2018, 'Nokia', 21000);
insert into brands values (2019, 'Nokia', 17000);
insert into brands values (2020, 'Nokia', 14000);


SELECT * FROM brands

;WITH Sales_inflation as
(

SELECT Year,brand,Amount,Amount -LAG(Amount,1) OVER (Partition by Brand order by Year) as Price_change
FROM brands

)

select * from brands where brand not in ( select brand from Sales_inflation where Price_change<0)