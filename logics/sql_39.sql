--https://www.linkedin.com/posts/saikishoregudiboina_sql32-activity-7132578381669302272-eQB9/?utm_source=share&utm_medium=member_desktop

create table Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
);

insert into Ameriprise_LLC values 
('T1','T1_mbr1','Y','Y'),
('T1','T1_mbr2','Y','Y'),
('T1','T1_mbr3','Y','Y'),
('T1','T1_mbr4','Y','Y'),
('T1','T1_mbr5','Y','N'),
('T2','T2_mbr1','Y','Y'),
('T2','T2_mbr2','Y','N'),
('T2','T2_mbr3','N','Y'),
('T2','T2_mbr4','N','N'),
('T2','T2_mbr5','N','N'),
('T3','T3_mbr1','Y','Y'),
('T3','T3_mbr2','Y','Y'),
('T3','T3_mbr3','N','Y'),
('T3','T3_mbr4','N','Y'),
('T3','T3_mbr5','Y','N');

Question:
𝐈𝐟 𝐜𝐫𝐢𝐭𝐞𝐫𝐢𝐚𝟏 𝐚𝐧𝐝 𝐜𝐫𝐢𝐭𝐞𝐫𝐢𝐚𝟐 𝐛𝐨𝐭𝐡 𝐚𝐫𝐞 '𝐘,' 𝐚𝐧𝐝 𝐚 𝐦𝐢𝐧𝐢𝐦𝐮𝐦 𝐨𝐟 𝐭𝐰𝐨 𝐭𝐞𝐚𝐦 𝐦𝐞𝐦𝐛𝐞𝐫𝐬 𝐬𝐡𝐨𝐮𝐥𝐝 𝐡𝐚𝐯𝐞 '𝐘,' 
𝐭𝐡𝐞𝐧 𝐭𝐡𝐞 𝐨𝐮𝐭𝐩𝐮𝐭 𝐬𝐡𝐨𝐮𝐥𝐝 𝐛𝐞 '𝐘,' 𝐞𝐥𝐬𝐞 '𝐍'.
note: just create a column 'output' in the input table itself as desired output

solution:

select *,
case when (count(case when criteria1='y' and criteria2='y' then 1 end) over(partition by teamid))>=2 then 'Y' else 'N' end AS OUTPUT
from Ameriprise_LLC
