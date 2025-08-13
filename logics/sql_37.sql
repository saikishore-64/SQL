--https://www.linkedin.com/feed/update/urn:li:activity:7131491211797823488/

create table phonelog(
Callerid int, 
Recipientid int,
Datecalled datetime
);
insert into phonelog(Callerid, Recipientid, Datecalled) values
(1, 2, '2019-01-01 09:00:00.000'),
(1, 3, '2019-01-01 17:00:00.000'),
(1, 4, '2019-01-01 23:00:00.000'),
(2, 5, '2019-07-05 09:00:00.000'),
(2, 3, '2019-07-05 17:00:00.000'),
(2, 3, '2019-07-05 17:20:00.000'),
(2, 5, '2019-07-05 23:00:00.000'),
(2, 3, '2019-08-01 09:00:00.000'),
(2, 3, '2019-08-01 17:00:00.000'),
(2, 5, '2019-08-01 19:30:00.000'),
(2, 4, '2019-08-02 09:00:00.000'),
(2, 5, '2019-08-02 10:00:00.000'),
(2, 5, '2019-08-02 10:45:00.000'),
(2, 4, '2019-08-02 11:00:00.000');

Question:
write a SQL query to find out the callers whose first and last call is with the same person on agiven day
columns: callerid -- who called, recipientid -- who recieved call

solution:
with cte1 as
 (
select callerid,cast(datecalled as date) as date_called,min(datecalled) as first_call,max(datecalled) as last_call
from phonelog
group by callerid,cast(datecalled as date)
)
select cte1.*,P1.recipientid as fist_recipient,p2.recipientid as last_recipient from cte1 
join phonelog P1
on cte1.callerid=P1.callerid and cte1.first_call=P1.datecalled
join phonelog P2
on cte1.callerid=p2.callerid and cte1.last_call = P2.datecalled
where P1.recipientid=p2.recipientid
