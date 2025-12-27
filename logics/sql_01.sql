--https://www.linkedin.com/feed/update/urn:li:activity:7119600357667733504/
  
Write an SQL query to find total number of matches played ,total wins, total losses, points by each team. 
for an each team win, u get 2 points and for a draw u get 1 point each

create table world_cup
(
match_no int,
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20)
);
INSERT INTO world_cup values(1,'ENG','NZ','NZ');
INSERT INTO world_cup values(2,'PAK','NED','PAK');
INSERT INTO world_cup values(3,'AFG','BAN','BAN');
INSERT INTO world_cup values(4,'SA','SL','SA');
INSERT INTO world_cup values(5,'AUS','IND','IND');
INSERT INTO world_cup values(6,'NZ','NED','NZ');
INSERT INTO world_cup values(7,'ENG','BAN','ENG');
INSERT INTO world_cup values(8,'SL','PAK','PAK');
INSERT INTO world_cup values(9,'AFG','IND','IND');
INSERT INTO world_cup values(10,'SA','AUS','SA');
INSERT INTO world_cup values(11,'BAN','NZ','NZ');
INSERT INTO world_cup values(12,'PAK','IND','IND');
INSERT INTO world_cup values(12,'SA','IND','DRAW');

solution:
  
with team as
 (
select team_1 as team
,case when team_1=winner then 1 else 0 end as win_flag 
,case when team_1!=winner and team_2!=winner then 1 end as draw_flag
from world_cup
union all
select team_2 as team
,case when team_2=winner then 1 else 0 end as win_flag
,case when team_1!=winner and team_2!=winner then 1 end as draw_flag
from world_cup
),
team_wins as 
(
select team,count(*) as total_matches,sum(win_flag) as wins from team group by team
)
,draws as 
(
select team,count(draw_flag) as draw_matches from team group by team
) 
select T.team,T.total_matches,T.wins,D.draw_matches
,T.total_matches-T.wins-D.draw_matches as lost_matches,
case when draw_matches=0 then wins*2 else wins*2+draw_matches*1 end as points
from team_wins T
join draws D on T.team=D.team
order by points desc


Post gress code:
select team,count(team) as total_matches 
,count(flag) as total_wins
,count(draw_flag) as total_draws

,count(team)-count(flag)-count(draw_flag) as total_losses
,case when team is not null then count(flag)*2 + count(draw_flag)*1 else 0 end as points

from (
select team_1 as team,
case when team_1 = winner then 1 
	  end as flag, case when winner='DRAW' then 1 end as draw_flag
from world_cup
union all
select team_2,
case when team_2 = winner then 1 
	  end as flag, case when winner='DRAW' then 1 end as draw_flag
from world_cup )
group by team
order by 2 desc
