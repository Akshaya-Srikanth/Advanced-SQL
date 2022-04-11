DROP TABLE IF EXISTS BILLINGS
create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);

insert into billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;

DROP TABLE IF EXISTS HOURSWORKED
create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4)


SELECT * FROM BILLINGS
SELECT * FROM HoursWorked

SELECT HW.emp_name,SUM(HW.bill_hrs*A.bill_rate) AS [GROSS EARNINGS]
FROM HOURSWORKED HW
JOIN (SELECT *,LEAD(DATEADD(DAY,-1,bill_date),1,'9999-12-31') OVER(PARTITION BY EMP_NAME ORDER BY BILL_DATE ASC) AS BILL_DATE_END
FROM BILLINGS) A
ON A.emp_name=HW.emp_name AND HW.work_date BETWEEN A.bill_date AND A.BILL_DATE_END
GROUP BY HW.emp_name

