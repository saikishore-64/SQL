--https://www.linkedin.com/posts/saikishoregudiboina_sql37-activity-7134420522322313217-7IYI/?utm_source=share&utm_medium=member_desktop

CREATE TABLE visits_table (
 id INT PRIMARY KEY,
 visit_date DATE,
 no_of_people INT
);
INSERT INTO visits_table (id, visit_date, no_of_people) VALUES
(1, '2017-02-01', 10),
(2, '2017-02-02', 110),
(3, '2017-02-03', 140),
(4, '2017-02-04', 98),
(5, '2017-02-05', 140),
(6, '2017-02-06', 120),
(7, '2017-02-07', 115),
(8, '2017-02-09', 189);

Question:
write a query to display records with 3 or more rows with consecutive id's and dates and the number of people >=100 for each record

Sol:
with rec_cte as (
select 1 as id,cast('2017-02-01' as date) as visit_date,10 as no_of_people
union all
select V.id,V.visit_date,V.no_of_people from visits_table V
join rec_cte R
on R.id+1=V.id and DATEADD(day,1,R.visit_date)=V.visit_date 
),
cte2 as (
select *,id-ROW_NUMBER() over(order by id) as grp
from rec_cte
where no_of_people>=100)
select id,visit_date,no_of_people from cte2
where grp=(select grp from cte2 group by grp having count(*)>=3)

The Logic provided is applicable to as many consecutive ids and dates u want to find and get in output by just changing count(*) to ur desired number of consecutive ids u want
