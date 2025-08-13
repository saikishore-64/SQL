--https://www.linkedin.com/feed/update/urn:li:activity:7135485043254181889/

CREATE TABLE player_table (
 player_id INT,
 device_id INT,
 event_date DATE,
 games_played INT
);

-- Insert data into player_table
INSERT INTO player_table (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-03-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2016-07-03', 5);

Question:
Write a SQL query to count the number of players that logged in for at-least two consecutive days starting from their first login date,then divide that number by total number of players to get a fraction round of to two decimals

Solution:
with cte as (
select *,
lead(event_date) over(partition by player_id order by event_date) as lead_date,
DATEADD(day,1,event_date) consecutive_day from player_table
)
select round(1.0*count(distinct T.player_id)/count(distinct P.player_id),2) as fraction from player_table P
left join
(select * from cte where lead_date=consecutive_day) T
on P.player_id=T.player_id
