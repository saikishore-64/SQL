Q‍‍‍‍‍‍‍uestion:
write an SQL query to find the record list of persons whose grand parent is alive. 
note: here in the input table, the person_status column represents status of person column not parent column

CREATE TABLE PersonInfo (
 person VARCHAR(10),
 parent VARCHAR(10),
 person_status VARCHAR(10)
);

INSERT INTO PersonInfo (person, parent, person_status) VALUES
 ('A', 'X', 'Alive'),
 ('B', 'Y', 'Dead'),
 ('X', 'X1', 'Alive'),
 ('Y', 'Y1', 'Alive'),
 ('X1', 'X2', 'Alive'),
 ('Y1', 'Y2', 'Dead');

solution:

select 
p1.person as child,
P1.parent,
P2.parent as grand_parent,
P3.person_status 
from personinfo P1
join 
personinfo P2 
on P1.parent=P2.person
join
personinfo P3 on P2.parent =P3.person
where P3.person_status='Alive'
