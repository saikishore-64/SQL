--https://www.linkedin.com/feed/update/urn:li:activity:7125066410732523521/

Question:
write a sql query to transpose the table provided student_id,different subject names as columns

create table marks_data(student_id int, subject varchar(50), marks int);

insert into marks_data values(1001, 'English' , 88);
insert into marks_data values(1001, 'Science', 90);
insert into marks_data values(1001, 'Maths',85);
insert into marks_data values(1002, 'English', 70);
insert into marks_data values(1002, 'Science', 80);
insert into marks_data values(1002, 'Maths',83);

solution:
select student_id,
sum(case when subject='English' then marks else 0 end) as english,
sum(case when subject='Science' then marks else 0 end) as science,
sum(case when subject='Maths' then marks else 0 end) as maths
from marks_data
group by student_id
