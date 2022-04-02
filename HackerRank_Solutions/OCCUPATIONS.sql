SELECT Name+'('+LEFT(Occupation,1)+')' FROM OCCUPATIONS order by Name,Occupation desc ;

SELECT 'There are a total of '+ cast(count(Name)as varchar(10))+' '+lower(Occupation)+'s.' 
FROM OCCUPATIONS group by Occupation order by count(Occupation);
