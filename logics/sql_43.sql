--https://www.linkedin.com/posts/saikishoregudiboina_sql36-activity-7134080813293305856-uARI/?utm_source=share&utm_medium=member_desktop

create table products_tble(
product_id int,
store1 int,
store2 int,
store3 int);

insert into products_tble (product_id,store1,store2,store3) values (0,95,100,105);
insert into products_tble (product_id,store1,store3) values (1,70,80);

Question:
write an sql query to rearrange the products table so that each row has product_id,store,price.If a product is not available in a store,don't include a row with that product_id and store combination in the result table

sol:

with cte as
 (
select product_id,'store1' as store,store1 as price from products_tble
union all
select product_id,'store2' as store,store2 as price from products_tble
union all
select product_id,'store3' as store,store3 as price from products_tble
) 
select * from cte where price is not null
order by 1,2
