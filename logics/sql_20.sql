--https://www.linkedin.com/feed/update/urn:li:activity:7124673795906310144/

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);

insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

questions:
1)write an SQL query to find date wise total number of users who made the purchase same day they installed the app

solution:
with cte as 
(
select event_date,user_id
,count(distinct event_name) as event_count
from activity 
group by event_date,user_id
)
select event_date,count(case when event_count=2 then 1 end) as users from cte
group by event_date

2)write an SQL query to find percentage of paid users in india,USA and any other country tagged as others

solution:
with cte as (
select *,
case when country in ('India','USA') then country else 'others' end as country_flag
from activity 
where event_name='app-purchase')

select country_flag,
100*count(*)/sum(count(*)) over() as percentage_purchased from cte
group by country_flag

3)write an SQL query to find users who installed the app on given day,how many did in app purchased on very next day

solution:
with cte as (
select *,lag(event_name,1) over(partition by user_id order by event_date) prev_event_name
,lag(event_date,1) over(partition by user_id order by event_date) prev_event_date
from activity)
select event_date,
count(case when event_name='app-purchase' and prev_event_name='app-installed' and DATEDIFF(day,prev_event_date,event_date)=1 then 1 end) no_of_users
from cte 
group by event_date
