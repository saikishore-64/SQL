--https://www.linkedin.com/feed/update/urn:li:activity:7116263374228783104/
Question:
Hr's in an Organization is looking to hire employees for the junior/senior positions. They have a total budget of 50000$ in all, they have to first fill up the senior positions (first priority) and then fill up the junior positions.
write an sql query to find the number of junior and senior positions depending on the budget criteria 

Create table candidates(
id int primary key,
positions varchar(10) not null,
salary int not null);

insert into candidates values(1,'junior',5000);
insert into candidates values(2,'junior',7000);
insert into candidates values(3,'junior',7000);
insert into candidates values(4,'senior',10000);
insert into candidates values(5,'senior',30000);
insert into candidates values(6,'senior',20000);

solution:
with rolling_sal as
 (
select *,sum(salary) over(partition by positions order by salary asc,id) as rolling_sum from candidates
 )
,seniors as
 (
select count(*) as seniors,sum(salary) as senior_sum from rolling_sal
where positions='senior' and rolling_sum<=50000
)
,juniors as
 (
select count(*) as juniors from rolling_sal 
where positions='junior' and rolling_sum<=50000 -(select senior_sum from seniors)
)
