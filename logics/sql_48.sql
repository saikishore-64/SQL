--https://www.linkedin.com/posts/saikishoregudiboina_sql41-activity-7137659350365466624-1axM/?utm_source=share&utm_medium=member_desktop

Scenario:
I had posts_table which describes
post_id -- each LinkedIn post with unique id
post_name -- post number of each post
posted date -- LinkedIn date of post

Question:
after 11 consecutive LinkedIn posts of mine(posts_table), I decided to revise two posts each day provided, continuing each day with a newer post.
write an SQL query to find the date that I would complete the revision of all the posts

-- Create the posts_table
CREATE TABLE posts_table (
 post_id INT PRIMARY KEY,
 post_name VARCHAR(255),
 post_date DATE
);
-- Insert data into the posts_table
INSERT INTO posts_table (post_id, post_name, post_date) VALUES
 (1, 'post_1', '2023-11-05'),
 (2, 'post_2', '2023-11-06'),
 (3, 'post_3', '2023-11-07'),
 (4, 'post_4', '2023-11-08'),
 (5, 'post_5', '2023-11-09'),
 (6, 'post_6', '2023-11-10'),
 (7, 'post_7', '2023-11-11'),
 (8, 'post_8', '2023-11-12'),
 (9, 'post_9', '2023-11-13'),
 (10, 'post_10', '2023-11-14'),
 (11, 'post_11', '2023-11-15');

solution:
with cte as
 (
select cast(11 as int) as post_id,
cast('post_11' as varchar) as post_name,
cast('2023-11-15' as date) as post_date,
cast(11 as int) as records
union all
select post_id+1 as post_id ,
cast(CONCAT('post','_',post_id+1) as varchar) as post_name,
DATEADD(day,1,post_date) as post_date,
records-2+1 as records
from cte 
where records<=11 and records>0 
)
select * from cte --- see the output what u r getting
select * from cte where records=0 -- u will get the date where revision will be completed
