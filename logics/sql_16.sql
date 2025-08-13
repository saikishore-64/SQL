--https://www.linkedin.com/feed/update/urn:li:activity:7123224236759924736/

question:
write a sql query to find average billing amount for each customer between 2019 to 2021, assume 0$ billing amount if nothing is billed for a particular year of that customer

create table billing
(
 customer_id   int
, customer_name  varchar(10)
, billing_id  varchar(5)
, billing_creation_date  date
, billed_amount int
);

insert into billing values (1, 'A', 'id1','10-10-2020', 100);
insert into billing values (1, 'A', 'id2','11-11-2020', 150);
insert into billing values (1, 'A', 'id3','12-11-2021', 100);
insert into billing values (2, 'B', 'id4','10-11-2019', 150);
insert into billing values (2, 'B', 'id5','11-11-2020', 200);
insert into billing values (2, 'B', 'id6','12-11-2021', 250);
insert into billing values (3, 'C', 'id7','01-01-2018', 100);
insert into billing values (3, 'C', 'id8','05-01-2019', 250);
insert into billing values (3, 'C', 'id9','06-01-2021', 300);

solution:
with cte1 as 
(
select customer_id,customer_name
,sum(billed_amount) as amount,count(*) as count_all,
count(distinct datepart(year,billing_creation_date)) as count_d
from billing
where datepart(year,billing_creation_date) between '2019' and '2021'
group by customer_id,customer_name
)
select customer_id,customer_name,
1.0*amount/(3-count_d+count_all)
from cte1
