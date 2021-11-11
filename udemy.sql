--Udemy Data Exploration
--Skills Used: Window Functions, CTE's, Aggregate Functions


/* deleting duplicates */
WITH RowCTE AS (

SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY 
		course_title,
		url,
		published_timestamp
			ORDER BY
				course_id 
				) row_num
FROM udemycourses
)

DELETE FROM udemycourses
USING udemycourses
JOIN RowCTE
	ON udemycourses.course_id = RowCTE.course_id
WHERE row_num > 1;

SELECT *
FROM udemycourses;

/* Show percentage of free courses */
SELECT count(*)/(select count(*) from udemycourses)*100 AS PercentageFreeCourses
FROM udemycourses
WHERE is_paid = 0;

/* Number of courses per subject */
SELECT subject, COUNT(*) AS SUBCount
FROM udemycourses
GROUP BY subject
ORDER BY SUBCount DESC;

/* How much profit did each subject make collectively? */
SELECT subject, SUM(price*num_subscribers) AS profit
FROM udemycourses
GROUP BY subject
ORDER BY profit DESC;

/* What courses have made the most money */
SELECT course_title, MAX(price*num_subscribers) AS profit
FROM udemycourses
GROUP BY course_title
ORDER BY profit DESC;

/* How many courses are SQL-related? */
SELECT COUNT(course_title) AS SQLCourses, AVG(price) AS AVGSQLPrice
FROM udemycourses
WHERE course_title LIKE "%SQL%"
ORDER BY price desc;

/* What is the most popular free courses by subject? */
SELECT course_title, num_subscribers, subject, is_paid
FROM udemycourses
WHERE (subject, num_subscribers) 
	IN (
		SELECT subject, MAX(num_subscribers)
		FROM udemycourses
		WHERE is_paid = 0
		GROUP BY subject);

/* What are the most reviewed courses for each level? */
SELECT course_title, num_reviews, level
FROM udemycourses
WHERE (level, num_reviews)
	IN (
		SELECT level, MAX(num_reviews)
		FROM udemycourses
		GROUP BY level);


/* Which courses offer the best cost benefit? Lowest price for most content */
SELECT course_title, price, content_duration
FROM udemycourses
WHERE (price, content_duration)
	IN (
		SELECT MIN(price), MAX(content_duration)
		WHERE is_paid = 1
		GROUP BY course_title)
ORDER BY price ASC, content_duration DESC;
