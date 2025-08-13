--https://www.linkedin.com/posts/saikishoregudiboina_sql30-activity-7130789089427001344-Lozv/?utm_source=share&utm_medium=member_desktop

Question:
Sometimes, payment transactions are repeated by accident; it could be due to user error, API failure or a retry error that causes a credit card to be charged twice.
Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. Count such repeated payments.
Assumptions:
The first transaction of such payments should not be counted as a repeated payment. This means, if there are two transactions performed by a merchant with the same credit card and for the same amount within 10 minutes, there will only be 1 repeated payment.

solution:
with cte as
(
select merchant_id,credit_card_id,amount,transaction_timestamp ,
lead(transaction_timestamp) over(partition by merchant_id,credit_card_id,amount order by transaction_timestamp ) as lead_timestamp
from transactions_tbl
)
,cte2 as
(
select *,DATEDIFF(minute,transaction_timestamp,lead_timestamp) as minute_diff from cte 
where cast(transaction_timestamp as date) = cast(lead_timestamp as date) and lead_timestamp is not null
)
select count(merchant_id)-1 as payment_count from cte2 where minute_diff<=10
group by merchant_id having count(*)>1
