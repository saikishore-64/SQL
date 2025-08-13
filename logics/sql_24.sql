24) Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. 
Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.
In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.
Sol:
select tweets_per_user,count(user_id) from 
(select user_id,count(*) as tweets_per_user from tweets 
where datepart(year,tweet_date)='2022' group by user_id) T
group by tweets_per_user
