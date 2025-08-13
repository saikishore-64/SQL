--https://www.linkedin.com/feed/update/urn:li:activity:7114995058004676608/

Question:
write an sql query that reports the buyers who have bought A8 but not iphone.
note that A8 and iphone are products present in product table

create table products_table(
product_id int,product_name varchar(30),unit_price int);

insert into products_table values(
1,'A8',10000),(2,'H4',8000),(3,'iphone',14000)

create table sales_table (seller_id int,product_id int,buyer_id int,sales_date date,quantity int,price int)

insert into sales_table values
(1,1,1,'2019-01-21',2,20000),
(1,2,2,'2019-01-21',1,8000),
(2,1,3,'2019-01-21',1,8000),
(3,3,3,'2019-01-21',3,28000)

sol:
select s.buyer_id from sales_table s
join products_table p
on s.product_id=p.product_id 
where product_name in ('A8','iphone')
group by s.buyer_id
having count(*)=1
