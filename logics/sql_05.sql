--https://www.linkedin.com/feed/update/urn:li:activity:7116731235770531840/

Question:
Write an sql query to merge the overlapping events in same hall???
note: the output should be in the form compared to input
hall_id start_date end_date
1 2023-01-13 2023-01-17
1 2023-01-18 2023-01-25
2 2022-12-09 2022-12-23
3 2022-12-01 2023-01-30

create table hall_events
(
hall_id integer,
start_date date,
end_date date
);

insert into hall_events values 
(1,'2023-01-13','2023-01-14')
,(1,'2023-01-14','2023-01-17')
,(1,'2023-01-15','2023-01-17')
,(1,'2023-01-18','2023-01-25')
,(2,'2022-12-09','2022-12-23')
,(2,'2022-12-13','2022-12-17')
,(3,'2022-12-01','2023-01-30');

solution:

with cte as
 (
select hall_id,start_date,end_date,row_number() over(order by hall_id,start_date) as rn from hall_events),
r_cte as
 (
select hall_id,start_date,end_date,rn,1 as flag from cte where rn=1
union all 
select 
cte.hall_id, cte.start_date, cte.end_date, cte.rn
,case when cte.hall_id=r_cte.hall_id and (cte.start_date between r_cte.start_date and r_cte.end_date or r_cte.start_date between cte.start_date and cte.end_date) then 0 else 1 end +flag as flag
from r_cte join cte on cte.rn=r_cte.rn+1
)
select hall_id, min(start_date) as start_date, max(end_date) as end_date from r_cte
group by hall_id,flag 
