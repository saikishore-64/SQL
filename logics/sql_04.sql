Question:
Write an SQL query that will return output having additional records for vacant positions i.e if u have vacant titles, 
then ur employee name should be 'vacant' adding the input with as many records equal to vacant posts
(for clarity see the output of the image)

create table job_positions (
id int,
title varchar(100),
groups varchar(10),
levels varchar(10), 
payscale int, 
totalpost int );

insert into job_positions values (1, 'General manager', 'A', 'l-15', 10000, 1); 
insert into job_positions values (2, 'Manager', 'B', 'l-14', 9000, 5); 
insert into job_positions values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10); 

create table job_employees ( 
id int, 
name varchar(100), 
position_id int );
 
insert into job_employees values (1, 'John Smith', 1); 
insert into job_employees values (2, 'Jane Doe', 2);
insert into job_employees values (3, 'Michael Brown', 2);
insert into job_employees values (4, 'Emily Johnson', 2); 
insert into job_employees values (5, 'William Lee', 3); 
insert into job_employees values (6, 'Jessica Clark', 3); 
insert into job_employees values (7, 'Christopher Harris', 3);
insert into job_employees values (8, 'Olivia Wilson', 3);
insert into job_employees values (9, 'Daniel Martinez', 3);
insert into job_employees values (10, 'Sophia Miller', 3)

Solution:

 with cte1 as
 (
select p.title,p.groups,p.levels,p.payscale,P.totalpost,E.name
from job_positions P left join
job_employees E on P.id=E.position_id
 )
,cte2 as
 (
select title,groups,levels,payscale,
max(totalpost) over(partition by title ) as max_posts,
count(*) over(partition by title ) as filled_posts,
max(totalpost) over(partition by title ) -count(*) over(partition by title ) as vacant_posts
from cte1
 )
,cte3 as 
(
select *,
case when vacant_posts>0 then 'vacant' end as employee_name
,row_number() over(partition by title order by title) as rn
from cte2 where vacant_posts>0 
)
select title,groups,levels,payscale,name as employee_name  from cte1 
union all
select title,groups,levels,payscale,employee_name from cte3 where rn<=vacant_posts order by groups
