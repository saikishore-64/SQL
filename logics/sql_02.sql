Question:
Write a sql query to find the average distances between two distinct points that is source and destination.
note: 
There might be different distances or routes for same source and destination points
#(check the input)

create table travel
(
src varchar(20),
dest  varchar(20),
distance  float
);
insert into travel values ('A', 'B', 21);
insert into travel values ('B', 'A', 28);
insert into travel values ('A', 'B', 19);
insert into travel values ('C', 'D', 15);
insert into travel values ('C', 'D', 17);
insert into travel values ('D', 'C', 16.5);
insert into travel values ('D', 'C', 18);

solution:

with cte as
 (
select src,dest,distance from travel
union
select dest,src,distance from travel
)
select src, dest, avg(distance) as avg_distance from cte
where src in ('A','C')
group by src, desc
