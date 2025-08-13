--https://www.linkedin.com/posts/saikishoregudiboina_sql39-activity-7135122634643554304-viZF/?utm_source=share&utm_medium=member_desktop

CREATE TABLE prod_list (
 product_id INTEGER PRIMARY KEY,
 price INTEGER,
 start_date DATE,
 end_date DATE
);

-- Insert data into the product_list table 
INSERT INTO prod_list (product_id, price, start_date, end_date) VALUES
(1, 1200, '2020-01-10', '2020-01-15'),
(2, 1500, '2020-01-15', '2020-01-22');

Question:
Write a SQL query to print all the dates ranging between each date & their respective prices for that day(given the ranges of dates but we need to bifurcate it for each day)

Sol:
with cte as (
select product_id,price,start_date,DATEADD(day,1,start_date) as end_date
from product_list
union all
select cte.product_id,cte.price,cte.end_date as start_date,DATEADD(day,1,cte.end_date) as end_date
from cte 
join product_list P 
on cte.product_id=P.product_id
where cte.end_date<>P.end_date
)
select * from cte order by 1
