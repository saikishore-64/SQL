--https://www.linkedin.com/feed/update/urn:li:activity:7113865771121876993/

Question:
write a query to find latest prices for all the products on or before 2019-08-16,
assume the updated prices for all products after 2019-08-16 is 10

sol:
with cte as
(
select *
,ROW_NUMBER() over(partition by product_id order by change_date desc) rn from product_tbl where change_date<='2019-08-17'
),
cte2 as
(
select distinct product_id from product_tbl
)
select CTE2.product_id ,case when new_price is null then 10 else new_price end PRICE 
from cte2 left join cte on cte2.product_id=cte.product_id and cte.rn=1
