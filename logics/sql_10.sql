--https://www.linkedin.com/feed/update/urn:li:activity:7112481869698371584/

Question:

write a query to report the ids and names of all managers, the number of employees who report directly to them, average age of reports rounded to nearest integer

CREATE TABLE report_table
(
emp_id SMALLINT,
name VARCHAR(20),
reports_to smallint,
age smallint
);

INSERT INTO report_table VALUES
(9,'henry',null,43),
(6,'alice',9,41),
(4,'bob',9,36),
(2,'winston',null,37);


solution:

with cte as
 (
select r1.*,cast(r1.age as float) as age_1, r2.name as report_manager from report_table r1 join report_table r2
on r1.reports_to=r2.emp_id
)
select reports_to as emp_id, report_manager, count(*) as report_countee, round(avg(age_1),0) as avg_age from cte
group by reports_to,report_manager
