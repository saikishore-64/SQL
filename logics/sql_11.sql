--https://www.linkedin.com/feed/update/urn:li:activity:7112138813803528192/

Question:
Write a query to get 𝑻𝒉𝒆 𝒅𝒊𝒇𝒇𝒆𝒓𝒆𝒏𝒄𝒆 𝒐𝒇 𝒂𝒎𝒐𝒖𝒏𝒕 𝒃𝒆𝒕𝒘𝒆𝒆𝒏 𝒂𝒑𝒑𝒍𝒆𝒔 & 𝒐𝒓𝒂𝒏𝒈𝒆𝒔 𝒇𝒐𝒓 𝒆𝒂𝒄𝒉 𝒅𝒂𝒚.

CREATE TABLE Sales_tbl(
sales_date DATE,
fruits VARCHAR(25),
sold_num SMALLINT
);

INSERT INTO Sales_tbl(sales_date, fruits, sold_num) VALUES
('2020-05-01', 'apples', 10),
('2020-05-01', 'oranges', 8),
('2020-05-02', 'apples', 15),
('2020-05-02', 'oranges', 15),
('2020-05-03', 'apples', 20),
('2020-05-03', 'oranges', 0),
('2020-05-04', 'apples', 15),
('2020-05-04', 'oranges', 16);

Solution:

with cte as (
select *
,lead(sold_num) over(partition by sales_date order by sold_num desc) as ln
,row_number() over(partition by sales_date order by sold_num desc) as rn
from sales_tbl where fruits in ('apples','oranges') 
)
select sales_date,sold_num-ln as diff_in_app_oranges from cte where rn=1
