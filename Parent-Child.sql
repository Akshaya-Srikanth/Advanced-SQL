/*We have two tables people and relations. The people table contains the details of each individual and the relations table contains the parent-child relationship between two individuals.
Write a query that prints the names of a child and his parents in individual columns respectively in order of the name of the child?*/


CREATE TABLE people
(id int primary key not null,
name varchar(20),
gender char(2));

CREATE TABLE relations
(
c_id int,
p_id int,
FOREIGN KEY (c_id) REFERENCES people(id),
foreign key (p_id) references people(id)
);


INSERT INTO people (id, name, gender)
values
(107,'Days','F'),
(145,'Hawbaker','M'),
(155,'Hansel','F'),
(202,'Blackston','M'),
(227,'Criss','F'),
(278,'Keffer','M'),
(305,'Canty','M'),
(329,'Mozingo','M'),
(425,'Nolf','M'),
(534,'Waugh','M'),
(586,'Tong','M'),
(618,'Dimartino','M'),
(747,'Beane','M'),
(878,'Chatmon','F'),
(904,'Hansard','F');

INSERT INTO relations(c_id, p_id)
values
(145, 202),
(145, 107),
(278,305),
(278,155),
(329, 425),
(329,227),
(534,586),
(534,878),
(618,747),
(618,904);


SELECT * FROM people
SELECT * FROM relations


--APPROACH 1:

SELECT C.name as Child,MAX(CASE WHEN P.gender='M' THEN P.name end)  as Father,MAX(CASE WHEN P.gender='F' THEN P.name end)  as Mother --using max to eliminate the nulls yeilded by case st
FROM relations R
JOIN people c --To fetch the corresponding child names
ON R.c_id= C.id
JOIN people P -- To fetch the parent names
on R.P_id=P.id
GROUP BY C.name 


--APPROACH 2: USING CTE ( For ease of readibility)
WITH FAMILY_CTE AS
(
SELECT C.name as Child,CASE WHEN P.gender='M' THEN P.name end  as Father,CASE WHEN P.gender='F' THEN P.name end  as Mother
FROM relations R
JOIN people c
ON r.c_id= C.id
JOIN people P
on r.P_id=P.id
)

SELECT Child,MAX(Father) as Father,MAX(Mother) as Mother
FROM FAMILY_CTE
GROUP BY Child



