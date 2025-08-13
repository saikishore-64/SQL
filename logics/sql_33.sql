--https://www.linkedin.com/feed/update/urn:li:activity:7129000726432780288/

CREATE TABLE transactions (
transaction_id INT,
product_id INT,
spend DECIMAL(10, 2),
transaction_date DATETIME
);

INSERT INTO transactions (transaction_id, product_id, spend, transaction_date) VALUES 
 (1341, 123424, 1500.60, '2019-12-31 12:00:00'),
 (1423, 123424, 1000.20, '2020-12-31 12:00:00'),
 (1623, 123424, 1246.44, '2021-12-31 12:00:00'),
 (1322, 123424, 2145.32, '2022-12-31 12:00:00'),
 (1344, 234412, 1800.00, '2019-12-31 12:00:00'),
 (1435, 234412, 1234.00, '2020-12-31 12:00:00'),
 (4325, 234412, 889.50, '2021-12-31 12:00:00'),
 (5233, 234412, 2900.00, '2022-12-31 12:00:00'),
 (2134, 543623, 6450.00, '2019-12-31 12:00:00'),
 (1234, 543623, 5348.12, '2020-12-31 12:00:00'),
 (2423, 543623, 2345.00, '2021-12-31 12:00:00'),
 (1245, 543623, 5680.00, '2022-12-31 12:00:00');

Question:
Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.
The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.

solution:
with cte1 as 
(
SELECT *,datepart(year,transaction_date) as year
,spend as curr_year_spend
,lag(spend) over(partition by product_id order by datepart(year,transaction_date)) as prev_year_spend
FROM transactions
)
,cte2 as
 (
select *,
CASE when prev_year_spend is NULL then NULL else ROUND(100*(curr_year_spend - prev_year_spend)/prev_year_spend,2) END
as yoy_rate
from cte1
)
select year,product_id,
curr_year_spend,prev_year_spend,yoy_rate
from cte2
