--https://www.linkedin.com/posts/saikishoregudiboina_sql34-activity-7133318263094067200-m8y9/?utm_source=share&utm_medium=member_desktop

CREATE TABLE CUSTOMER_ORDERS (
 customer_id BIGINT,
 order_id BIGINT ,
 sales_usd DECIMAL(12, 2),
 order_datetime DATETIME
);

INSERT INTO CUSTOMER_ORDERS (customer_id, order_id, sales_usd, order_datetime) VALUES
 (3362462944, 4496, 50.6, '2021-11-30 16:10'),
 (9974574193, 92589, 27.81, '2021-11-30 16:05'),
 (8434103670, 80710, 96.6, '2021-11-30 16:18'),
 (1735736329, 32524, 29.36, '2021-11-30 16:20'),
 (7162944850, 74378, 11.16, '2021-11-30 18:16'),
 (4076426500, 47201, 53.55, '2021-11-30 16:20'),
 (8434103670, 50015, 73.9, '2021-11-30 18:08'),
 (1735736329, 81255, 80.75, '2021-11-30 20:18'),
 (7162944850, 98671, 95.75, '2021-11-30 17:08'); 

Question:
Write a SQL query that will produce data used to populate a histogram that shows the how many unique orders customers have during the month of November 2021. Ensure the query provides the count of customers who had zero orders in Nov 2021

solution:

with cte as (
select customer_id, COUNT(DISTINCT order_id) as num_orders from customer_orders
where datepart(YEAR,cast(order_datetime as date)) = 2021
and datepart(month,cast(order_datetime as date)) = 11
group by customer_id
)
select num_orders,count(customer_id) as customer_count
from cte
group by num_orders
order by num_orders;
