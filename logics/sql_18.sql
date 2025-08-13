--https://www.linkedin.com/feed/update/urn:li:activity:7123926326545158144/

Question:
write an SQL query to find companies who have At-least 2 users who speaks English and German in both the languages

create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values 
(1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');

Solution:
select T.company_id,count(user_id) as no_of_user_id from 
(
select company_id,user_id,
count(*) as count_all,
count(case when language in ('english','german') then 1 end) as count_EG
from company_users 
group by company_id,user_id
having count(case when language in ('english','german') then 1 end)=2
) T
group by T.company_id
having count(user_id)>=2
