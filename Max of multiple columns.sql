--How to find Maximum of multiple columns
DROP TABLE IF EXISTS order_tab
create table order_tab
(
    v_dept varchar(30),
    year_2018 INT,
    year_2019 INT,
    year_2020 INT,
    year_2021 INT,
    year_2022 INT
);

insert into order_tab values('A',1,2,3,4,5);
insert into order_tab values('B',10,20,30,40,50);
insert into order_tab values('C',10,25,30,45,50);
insert into order_tab values('D',15,20,35,40,55);
insert into order_tab values('E',10,20,35,45,97);

SELECT * FROM order_tab

SELECT V_DEPT ,
(SELECT MAX (SALES) FROM (VALUES ([YEAR_2018]),([YEAR_2019]),([YEAR_2020]),([YEAR_2021]),([YEAR_2022])) AS TBLSALES(SALES)
) AS MAX_YEAR_SALES
FROM order_tab
