17)
write an sql query to find number of candidates who knows both sql and python only?

Sol:
select student_id, 
count(*) as count_all,
count(case when skill in ('sql','python') then 1 end) as count_sp
from students
group by student_id
having count(case when skill in ('sql','python') then 1 end)=2 and count(*)=2
