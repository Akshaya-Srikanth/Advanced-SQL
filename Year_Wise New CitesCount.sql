--WAQ FOR YEARWISE COUNT OF NEW CITIES THE OPERATIONS WERE STARTED
DROP TABLE IF EXISTS business_city
create table business_city (
business_date date,
city_id int
);

INSERT INTO business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);

SELECT * FROM business_city
/* expected o/p
2020 2
2021 1
2022 1
*/

DROP TABLE IF EXISTS #Temp_year
SELECT YEAR(business_date) AS Business_year,city_id
INTO #Temp_year
FROM business_city


-- APPROACH 1: USING SELF JOIN

SELECT Y1.Business_year,count(DISTINCT case when Y2.Business_year IS NULL THEN Y1.CITY_ID ELSE NULL END) AS [#NOOFNEWCITIES]
FROM #Temp_year Y1
LEFT JOIN #Temp_year Y2
ON Y1.Business_year>Y2.Business_year AND Y1.city_id=Y2.city_id
GROUP BY Y1.Business_year 

--APPROACH 2:ROW_NUMBER
SELECT Business_year,COUNT(DISTINCT CITY_ID) AS [#NOOFNEWCITIES]
FROM 
(
SELECT Business_year,CITY_ID,ROW_NUMBER() OVER(PARTITION BY CITY_ID ORDER BY Business_year) AS RN
FROM #Temp_year 
)T1
WHERE T1.RN=1
GROUP BY Business_year

