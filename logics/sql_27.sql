--https://www.linkedin.com/feed/update/urn:li:activity:7126515928061644800/

Question:
Write a SQL query to fetch the records of brand whose amount is increasing every year

create table brands
(
 Year   int,
 Brand  varchar(20),
 Amount int
);
insert into brands values (2018, 'Apple', 45000);
insert into brands values (2019, 'Apple', 35000);
insert into brands values (2020, 'Apple', 75000);
insert into brands values (2018, 'Samsung',   15000);
insert into brands values (2019, 'Samsung',   20000);
insert into brands values (2020, 'Samsung',   25000);
insert into brands values (2018, 'Nokia', 21000);
insert into brands values (2019, 'Nokia', 17000);
insert into brands values (2020, 'Nokia', 14000);

sol:

with cte as 
(
select B1.year as start_year
,case when B1.year>B2.year and B1.amount>B2.amount then B1.year end as comp_year
,B1.brand
from brands B1
join
Brands B2
on B1.brand=B2.brand
 )
select brand from cte
group by brand
having count(distinct comp_year) in (select count(distinct year)-1 from brands)
-- the reason for -1 is as we are comparing year by year 2018-2019,2019-2020 so we get only 2 distinct years in col wise
