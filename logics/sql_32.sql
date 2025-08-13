32) Assume you're given a table containing information on Facebook user actions. 
  Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".
Hint:
An active user is defined as a user who has performed actions such as 'sign-in', 'like', or 'comment' in both the current month and the previous month.

  Sol:
with cte1 as 
(SELECT *,date_part('month',event_date) as month
FROM user_actions
where  event_type in ('sign-in', 'like', 'comment' )
),cte2 as (
select *,
lead(month) over(partition by user_id ORDER BY user_id) as lead_month
from cte1)
select lead_month,count(distinct user_id) as monthly_active_users 
from cte2
where month+1=lead_month and lead_month=7
group by lead_month
