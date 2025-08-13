--https://www.linkedin.com/posts/saikishoregudiboina_sql45-activity-7140920847329820672-_l-6?utm_source=share&utm_medium=member_desktop&rcm=ACoAACg184QBFyuXZdDA0SPYWvYfg646jV-SgT8

Question:
A frog has fallen into a pit that is 30 m deep.each day the frog climbs 3m,
but falls back 2m at night.how many days does it take for it to escape from pit

solution:
with cte as
 (
select 1 as day,3 as forward,2 as backward,30 as reach_point, 3-2 as net_forward
union all
select day+1 as day,forward,backward,reach_point,
case when 
 net_forward+forward=reach_point then net_forward+forward 
 else net_forward+forward-backward 
 end as 'net_forward'
from cte
where net_forward+forward<=reach_point)
select * from cte where net_forward=reach_point
