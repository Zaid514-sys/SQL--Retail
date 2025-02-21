**SQL Mentor User Performance Dataset**

The dataset consists of information about user submissions for an online learning platform. Each submission includes:
User ID
Question ID
Points Earned
Submission Timestamp
Username

This data allows you to analyze user performance in terms of correct and incorrect submissions, total points earned, and daily/weekly activity.

**SQL Problems and Questions**

-- Q.1 List all distinct users and their stats (return user_name, total_submissions, points earned)

'''SQL

select 
	username,
	count(id) as total_submission,
	sum(points)	as points_earned
from user_submissions
group by username;

'''

-- Q.2 Calculate the daily average points for each user.

'''SQL

	extract(day from submitted_at) as day_wise,
	username,
	round(avg(points),2) as avg_points
from user_submissions
group by submitted_at,username
order by username;

'''

-- Q.3 Find the top 3 users with the most positive submissions for each day.

'''SQL
select 
	extract(day from submitted_at) as day_wise,
	username,
	sum(case
		when points > 0 then 1 else 0
		end ) as correct_submissions
from user_submissions
group by 1,2
limit 3;

'''
-- Q.4 Find the top 5 users with the highest number of incorrect submissions.

'''SQL

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
ORDER BY incorrect_submissions DESC;

'''

-- Q.5 Find the top 10 performers for each week.

'''SQL

select 
	username,
	sum(points) as total_point,
	sum(question_id) as solved,
	extract(week from submitted_at) as week_no,
	DENSE_RANK() OVER(PARTITION BY EXTRACT(WEEK FROM submitted_at) ORDER BY SUM(points) DESC) as rank
from user_submissions
group by 1,4
ORDER BY  week_no, total_point DESC;

'''


**Key SQL Concepts **

Aggregation: Using COUNT, SUM, AVG to aggregate data.
Date Functions: Using EXTRACT() and TO_CHAR() for manipulating dates.
Conditional Aggregation: Using CASE WHEN to handle positive and negative submissions.
Ranking: Using DENSE_RANK() to rank users based on their performance.
Group By: Aggregating results by groups (e.g., by user, by day, by week).


**Conclusion**

This project provides an excellent opportunity for beginners to apply their SQL knowledge to solve practical data problems. By working through these SQL queries, you'll gain hands-on experience with data aggregation, ranking, date manipulation, and conditional logic.












