--https://www.linkedin.com/posts/saikishoregudiboina_sql44-activity-7140558465940303872-OnBv/?utm_source=share&utm_medium=member_desktop

scenario:
I have a table named 'string' which had columns i.e
id: unique id numbers for each name
name: its a column of characters with a different name length

Question:
write a SQL query to populate each record name equal to length of each record name 

--create and insert statements

CREATE TABLE string (
 id INT PRIMARY KEY IDENTITY,
 name VARCHAR(255)
);
INSERT INTO string (name) VALUES
('G'),
('sai'),
('kishore');

Solution:
with cte as (
select *,count(*) over(partition by name) as name_count,LEN(name) as length from string
union all
select id,name,name_count+1 as name_count,length
from cte
where name_count< length)
select id,name,name_count from cte order by 1,3
