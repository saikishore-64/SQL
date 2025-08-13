--https://www.linkedin.com/posts/saikishoregudiboina_sql35-activity-7133725953649737729-WZ5m/?utm_source=share&utm_medium=member_desktop

CREATE TABLE flights 
(
cid VARCHAR(512),
fid VARCHAR(512),
origin VARCHAR(512),
Destination VARCHAR(512)
);

INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f1', 'Del', 'Hyd');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f2', 'Hyd', 'Blr');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f3', 'Mum', 'Agra');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f4', 'Agra', 'Kol');

Question:
write an sql query to find origin and final destination of each cid

sol:
select f1.cid,f1.origin,f2.destination from flights f1
join flights f2
on f1.origin<>f2.destination
where f1.destination=f2.origin
order by 1

🏷🏷🏷🏷🏷🏷
CREATE TABLE sales
(
order_date date,
customer VARCHAR(512),
qty INT
);

INSERT INTO sales (order_date, customer, qty) VALUES ('2021-01-01', 'C1', '20');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-01-01', 'C2', '30');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-02-01', 'C1', '10');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-02-01', 'C3', '15');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-03-01', 'C5', '19');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-03-01', 'C4', '10');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C3', '13');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C5', '15');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C6', '10');

Question:
find count of each customer added in each month

Sol:
with cte as  (
select * from sales S
join
(select order_date as ord_date, customer as cust, min(order_date) over(partition by customer order by order_date) as min_date 
from sales) T
on S.order_date=T.ord_date
where customer=cust and order_date=min_date
) select order_date,count(distinct customer) as new_customer_count from cte 
group by order_date
order by 1
