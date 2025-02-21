-- SQL Mini Project 10/10
-- SQL Mentor User Performance

-- DROP TABLE user_submissions; 

CREATE TABLE user_submissions (
    id SERIAL PRIMARY KEY,
    user_id BIGINT,
    question_id INT,
    points INT,
    submitted_at TIMESTAMP WITH TIME ZONE,
    username VARCHAR(50)
);

SELECT * FROM user_submissions;


-- Q.1 List all distinct users and their stats (return user_name, total_submissions, points earned)
-- Q.2 Calculate the daily average points for each user.
-- Q.3 Find the top 3 users with the most positive submissions for each day.
-- Q.4 Find the top 5 users with the highest number of incorrect submissions.
-- Q.5 Find the top 10 performers for each week.


-- Please note for each questions return current stats for the users
-- user_name, total points earned, correct submissions, incorrect submissions no


-- solution


-- Q.1 List all distinct users and their stats (return user_name, total_submissions, points earned)


select 
	username,
	count(id) as total_submission,
	sum(points)	as points_earned
from user_submissions
group by username;


-- Q.2 Calculate the daily average points for each user.

select 
	extract(day from submitted_at) as day_wise,
	username,
	round(avg(points),2) as avg_points
from user_submissions
group by submitted_at,username
order by username;

-- Q.3 Find the top 3 users with the most positive submissions for each day.

select 
	extract(day from submitted_at) as day_wise,
	username,
	sum(case
		when points > 0 then 1 else 0
		end ) as correct_submissions
from user_submissions
group by 1,2
limit 3;


SELECT * FROM user_submissions;


-- Q.4 Find the top 5 users with the highest number of incorrect submissions.


SELECT 
	username,
	SUM(CASE 
		WHEN points < 0 THEN 1 ELSE 0
	END) as incorrect_submissions,
	SUM(CASE 
			WHEN points > 0 THEN 1 ELSE 0
		END) as correct_submissions,
	SUM(CASE 
		WHEN points < 0 THEN points ELSE 0
	END) as incorrect_submissions_points
FROM user_submissions
GROUP BY 1
ORDER BY incorrect_submissions DESC

-- Q.5 Find the top 10 performers for each week.

SELECT * FROM user_submissions;

select 
	username,
	sum(points) as total_point,
	sum(question_id) as solved,
	extract(week from submitted_at) as week_no,
	DENSE_RANK() OVER(PARTITION BY EXTRACT(WEEK FROM submitted_at) ORDER BY SUM(points) DESC) as rank
from user_submissions
group by 1,4
ORDER BY  week_no, total_point DESC


















