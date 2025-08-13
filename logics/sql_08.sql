--https://www.linkedin.com/feed/update/urn:li:activity:7114286497830207488/

Question:
write a query to change seats for the adjacent students & if number of students is odd, there is no need to change the last one's seat

create table seats_table(
id int,
student varchar(30));

insert into seats_table values
(1,'A'),
(2,'D'),
(3,'E'),
(4,'G'),
(5,'J');


sol:
select *
,isnull(case
 when id%2=1 then lead(student) over(order by id) 
 else lag(student) over(order by id) end ,student)
from seats_table
