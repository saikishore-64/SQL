--https://www.linkedin.com/posts/saikishoregudiboina_sql33-activity-7132646320984526848-O0uA/?utm_source=share&utm_medium=member_desktop

create table emp_table (emp_name varchar(30) , emp_doj varchar(20) , emp_increment_date varchar(20) , salary int); 

insert into emp_table values ('A' , '06-09-2003' , '06-09-2022' , 100);
insert into emp_table values ('B' , '06-09-2010' , '06-09-2023' , 200);
insert into emp_table values ('C' , '06-09-2015' , '06-09-2022' , 250);
insert into emp_table values ('D' , '06-09-2012' , '06-09-2023' , 400);
insert into emp_table values ('E' , '06-09-2018' , '06-09-2022' , 90);
insert into emp_table values ('B' , '06-09-2010' , '06-09-2022' , 280);
insert into emp_table values ('F' , '06-09-2010' , '06-09-2022' , 120);
insert into emp_table values ('G' , '06-09-2020' , '06-09-2023' , 80);
insert into emp_table values ('K' , '06-09-2010' , '06-09-2023' , 40);
insert into emp_table values ('E' , '06-09-2018' , '06-09-2023' , 110);
insert into emp_table values ('Z' , '06-09-2021' , '06-09-2023' , 220);
insert into emp_table values ('A' , '06-09-2003' , '06-09-2023' , 110);
insert into emp_table values ('C' , '06-09-2015' , '06-09-2023' , 260);
insert into emp_table values ('B' , '06-09-2010' , '06-09-2021' , 250);
insert into emp_table values ('B' , '06-09-2010' , '06-09-2020' , 280);

 Question:
Write a SQL code & provide only those employee's who got incremental hike year over year.

solution:

with cte as
 (
select *,lead(salary) over(partition by emp_name order by emp_increment_date) as next_year_salary
,count( emp_increment_date) over(partition by emp_name ) as count
from emp_table 
),
cte2 as (
select *,count(next_year_salary) over(partition by emp_name) as count_next_year from cte 
where next_year_salary>salary
)
select emp_name from cte2 where 
count-1=count_next_year
