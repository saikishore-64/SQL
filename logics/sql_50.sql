--https://www.linkedin.com/posts/saikishoregudiboina_sql43-activity-7140196068708814848-zgQb/?utm_source=share&utm_medium=member_desktop

Scenario:
I have a table name "presence" which has two columns i.e
date: It is a column that shows availability and non availability dates
availability: 0 indicates 'not available' and 1 indicates 'available'

Question:
write a SQL query to find minimum date and maximum date for each section of available and non available dates

--create and insert statements

CREATE TABLE presence (
 date DATE PRIMARY KEY,
 availability INT
);

INSERT INTO presence (date, availability) VALUES 
('2023-11-05', 0),
('2023-11-06', 0),
('2023-11-07', 0),
('2023-11-10', 1),
('2023-11-11', 1),
('2023-11-15', 0),
('2023-11-16', 0),
('2023-11-17', 1);

solution:
with cte as
(
select *,
case when LAG(availability) over(order by date)<>availability then 1 else 0 end as toggle_flg
from presence),
cte2 as (
select *,sum(toggle_flg) over(order by date) as rolling_sum
from cte ),
cte3 as (
select *,max(date) over(partition by rolling_sum) as max_date
,ROW_NUMBER() over(partition by rolling_sum order by date) as rn
from cte2 )
select date as min_date,max_date,availability from cte3 where rn=1
