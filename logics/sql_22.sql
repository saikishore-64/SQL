--https://www.linkedin.com/feed/update/urn:li:activity:7125391043511877632/

Question:
write an sql query to return account_no and transaction_date when the account balance reached to 1000
note:
include only those accounts whose balance currently is >=1000

create table account_balance
(
 account_no   varchar(20),
 transaction_date   date,
 debit_credit   varchar(10),
 transaction_amount decimal
);

insert into account_balance values ('acc_1','2022-01-20','credit', 100);
insert into account_balance values ('acc_1','2022-01-21','credit', 500);
insert into account_balance values ('acc_1','2022-01-22','credit', 300);
insert into account_balance values ('acc_1','2022-01-23','credit', 200);
insert into account_balance values ('acc_2','2022-01-20','credit', 500);
insert into account_balance values ('acc_2','2022-01-21','credit', 1100);
insert into account_balance values ('acc_2','2022-01-22','debit', 1000);
insert into account_balance values ('acc_3','2022-01-20','credit', 1000);
insert into account_balance values ('acc_4','2022-01-20','credit', 1500);
insert into account_balance values ('acc_4','2022-01-21','debit', 500);
insert into account_balance values ('acc_5','2022-01-20','credit', 900);

solution:
with cte as
 (
select *,
sum(case when debit_credit='credit' then transaction_amount else -1*transaction_amount end) over(partition by account_no ) as total_sum,
sum(case when debit_credit='credit' then transaction_amount else -1*transaction_amount end) over(partition by account_no order by transaction_date) as amount
from account_balance
)
select 
account_no,min(transaction_date) as date_reached_thousand
from cte
where total_sum>=1000 and amount>=1000
group by account_no
