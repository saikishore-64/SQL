--https://www.linkedin.com/posts/saikishoregudiboina_sql42-activity-7138444531951144960-5ksk/?utm_source=share&utm_medium=member_desktop

Scenario:
I have a table named digit_table where columns i.e
id - id for each record
mobiles - phone_numbers that are separated with a delimiter ',' in each record

Question:
Now develop a SQL query to make the mobiles column spilt into row by row where delimiter comes 
note: I need the last charecters after last delimiter as well 

CREATE TABLE digit_table (
 id INT PRIMARY KEY IDENTITY,
 mobiles VARCHAR(255) 
);
INSERT INTO digit_table (mobiles) VALUES
 ('95,345,1233,12345'),
 ('1,23,345,567'),
 ('1111,123');

solution:
with cte as (
select id,mobiles,
CHARINDEX(',',mobiles) AS del_pos,
1 as delimiter_number,
len(mobiles)-CHARINDEX(',', REVERSE(mobiles))+1 as last_delimiter_index,
SUBSTRING(mobiles, 1,CHARINDEX(',', mobiles )-1) as number
from digit_table
union all
select id,mobiles,
CHARINDEX(',',mobiles,del_pos+1) as del_pos,--next delimter position
delimiter_number+1 as delimiter_number, --next delimiter number
last_delimiter_index,
case when CHARINDEX(',',mobiles,del_pos+1)=0 then SUBSTRING(mobiles, del_pos+1,len(mobiles)-last_delimiter_index) else
SUBSTRING(mobiles, del_pos+1,CHARINDEX(',',mobiles,del_pos+1)-del_pos-1) end as number
from cte
where del_pos<=last_delimiter_index and del_pos>0
)select id,mobiles,delimiter_number,number from cte order by 1,3
