USE sakila;
-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MIN(f.length) AS min_duration, MAX(f.length) AS max_duration FROM sakila.film AS f;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

SELECT 
  FLOOR(AVG(f.length) / 60) AS hours,
  ROUND(AVG(f.length) % 60, 0) AS minutes
FROM sakila.film AS f;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(MAX(r.rental_date), MIN(r.rental_date))  FROM sakila.rental AS r;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT * FROM sakila.rental;
SELECT r.*, 
DATE_FORMAT(r.rental_date, "%M" ) AS month, 
DATE_FORMAT(r.rental_date, "%W" ) AS weekday
FROM sakila.rental AS r
LIMIT 20;


-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT r.*,  
DATE_FORMAT(r.rental_date, "%W" ) AS weekday,
CASE
	WHEN DATE_FORMAT(r.rental_date, "%W" ) IN ('Saturday', 'Sunday') THEN 'weekend'
	ELSE 'workday' 
END AS DAY_TYPE
FROM sakila.rental AS r;

/*-- 3. You need to ensure that customers can easily access information about the movie collection. 
To achieve this, retrieve the film titles and their rental duration. 
If any rental duration value is NULL, replace it with the string 'Not Available'. 
Sort the results of the film title in ascending order.
Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
Hint: Look for the IFNULL() function. */

SELECT f.title, f.rental_duration,
	IFNULL(f.rental_duration, 'Not Available') AS RENTAL_STATUS
FROM sakila.film AS f;

-- 4. Bonus
SELECT concat(c.first_name, ' ', c.last_name), LEFT(c.email,3) AS first_3_char_email
FROM sakila.customer AS c
ORDER BY c.last_name ASC;

-- Challenge 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(f.title) FROM sakila.film AS f
WHERE f.release_year <= 2006;

-- 1.2 The number of films for each rating.
SELECT COUNT(f.title) AS number_of_films, f.rating FROM sakila.film AS f
GROUP BY f.rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT COUNT(f.title) AS number_of_films, f.rating FROM sakila.film AS f
GROUP BY f.rating
ORDER BY number_of_films DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT ROUND(AVG(f.length), 2) AS avg_length, f.rating FROM sakila.film AS f
GROUP BY f.rating
ORDER BY avg_length DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT ROUND(AVG(f.length), 2) AS avg_length, f.rating FROM sakila.film AS f
GROUP BY f.rating
HAVING avg_length > 120
ORDER BY avg_length DESC;

-- 3. Bonus
SELECT a.last_name 
FROM sakila.actor AS a
GROUP BY a.last_name
HAVING COUNT(a.last_name) = 1;
