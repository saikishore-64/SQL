--https://www.linkedin.com/feed/update/urn:li:activity:7128614795347443713/

Question:
write an SQL query for table cricket_runs (ODI_match_data_50overs) 
to fetch runs scored per over 
note:
batsman_runs are the runs that are scored only by batsman even the ball is a nobe or wide

we need an output to get total runs(batsman_runs+extra runs) for each over in output
for each wide ball--1 run
for each nobe ball-- 1run

solution:
with cte1 as
 (
SELECT * 
,case when delivery_type='legal' then batsman_runs else batsman_runs+1 end as runs_per_ball
,case when delivery_type='legal' then 1 else 0 end as legal_flag
,sum(case when delivery_type='legal' then 1 else 0 end) over(order by ball_no) cum_ball_sum
from CRICKET_RUNS )
,cte2 as
 (
select *
,case when delivery_type='legal' and cum_ball_sum%6=0 then 1 else 0 end as cum_ball_sum_6_flag
,sum(runs_per_ball) over(order by ball_no) as cum_runs_per_ball
from cte1 
)
,cte3 as
 (
select *
,ROW_NUMBER() over(order by ball_no) as rn
from cte2
 where cum_ball_sum_6_flag=1 
)

select rn as over_number
,case when rn=1 
then cum_runs_per_ball else cum_runs_per_ball-(Lag(cum_runs_per_ball) over(order by ball_no)) end 
as runs_per_over
from cte3
