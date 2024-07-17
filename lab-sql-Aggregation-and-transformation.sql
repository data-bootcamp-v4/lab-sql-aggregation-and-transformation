use sakila;
-- Challenge 1
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(rental_duration) AS max_duration, MIN(rental_duration) As min_duration
From Film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT MAX(rental_duration)AS Max_duration, MIN(rental_duration)As min_duration
from film;

-- 2 You need to gain insights related to rental dates:
--  Calculate the number of days that the company has been operating.
--  : To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date))As active_days
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT*,DATE_FORMAT(rental_date,'%M') AS MONTH,DATE_FORMAT(rental_date,'%W') AS weekday
FROM rental;

-- 2.3Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week

SELECT*, case WHEN DATE_FORMAT(rental_date,'%M') IN ('saturday','sunday')
THEN 'weekend'
ElSE 'workday' END AS day_type
FROM rental;

-- 3 You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title, IFNULL (rental_duration,'NOT AVAILABLE') as rental_duration
FROM Film
ORDER BY title ASC;

-- CHELENGE 2
-- , you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- .1he total number of films that have been released 
SELECT COUNT(*) AS 'NUM_films'FROM film;

--  1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS 'num_films' FROM film
GROUP BY rating;

--  1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly
SELECT rating,COUNT(*) AS 'num_films'FROM film
GROUP BY rating
ORDER BY num_films DESC;


-- 2 Using the film table, determine:
-- 2The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2) AS avg_lenght  FROM film
GROUP BY rating
ORDER BY num_length DESC;

--  2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, round(AVG(length),2) AS avg_duration FROM film
GROUP BY rating
HAVING AVG_duration > 120
ORDER BY avg_duration DESC;