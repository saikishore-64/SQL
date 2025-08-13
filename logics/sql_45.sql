--https://www.linkedin.com/posts/saikishoregudiboina_sql38-activity-7134775379000520704-mGXB/?utm_source=share&utm_medium=member_desktop

CREATE TABLE exp_table (
 id INT PRIMARY KEY,
 left_operand VARCHAR(10),
 operator VARCHAR(1),
 right_operand VARCHAR(10)
);

-- Insert data into exp_table
INSERT INTO exp_table (id, left_operand, operator, right_operand) VALUES
(1, 'x', '>', 'y'),
(2, 'x', '<', 'y'),
(3, 'x', '=', 'y'),
(4, 'y', '>', 'x'),
(5, 'y', '<', 'x'),
(6, 'x', '>', 'x');

-- Create values_table
CREATE TABLE values_table (
 name VARCHAR(10) PRIMARY KEY,
 value INT
);

-- Insert data into values_table
INSERT INTO values_table (name, value) VALUES
('x', 66),
('y', 77);

Question:
Write an SQL query to evaluate the boolean_expressions using values_table and exp_table

sol:
with cte as (
select E.*,V.value as first,V1.value as last from exp_table E
join values_table V
on E.left_operand=v.name
join values_table V1
on E.right_operand=V1.name)
select id,left_operand,operator,right_operand,
case      when operator='>' and first>last then 'TRUE' 
 when operator='<' and first<last then 'TRUE' 
 when operator='=' and first=last then 'TRUE' else 'FALSE' end as output
from cte
