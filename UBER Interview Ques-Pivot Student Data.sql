DROP TABLE IF EXISTS MARKS_DATA

create table marks_data(student_id int, subject varchar(50), marks int);
insert into marks_data values(1001, 'English', 88);
insert into marks_data values(1001, 'Science', 90);
insert into marks_data values(1001, 'Maths', 85);
insert into marks_data values(1002, 'English', 70);
insert into marks_data values(1002, 'Science', 80);
insert into marks_data values(1002, 'Maths', 83);

SELECT * FROM MARKS_DATA

--APPROACH 1: PIVOT DATA
SELECT student_id,[ENGLISH],[SCIENCE],[MATHS]
FROM 
(SELECT student_id,SUBJECT,marks
FROM MARKS_DATA) AS SOURCE
PIVOT
( MAX(MARKS) FOR SUBJECT  IN ([ENGLISH],[SCIENCE],[MATHS])
) AS RES;


--APPROACH 2: USING CASE STATEMENTS
SELECT student_id,
MAX(CASE WHEN SUBJECT ='ENGLISH' THEN marks  END) AS ENGLISH
,MAX(CASE WHEN SUBJECT ='SCIENCE' THEN marks  END) AS [SCIENCE]
,MAX(CASE WHEN SUBJECT ='MATHS' THEN marks  END) AS [MATHS]

FROM MARKS_DATA
GROUP BY student_id
