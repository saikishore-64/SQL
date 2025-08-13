--https://www.linkedin.com/feed/update/urn:li:activity:7126802823895293952/

Question:
Write an SQL query to find all numbers that appear at least three times consecutively.

create table logs
(
id int,
num int);

insert into logs values
(1,1),
(2,1),
(3,1),
(4,2),
(5,1),
(6,2),
(7,2)

sol:
select distinct L1.num from logs L1
join 
logs L2 
on L1.id=L2.id+1 and L1.num=L2.num
join logs L3
on L1.id=L3.id+2 and L1.num=L3.num
