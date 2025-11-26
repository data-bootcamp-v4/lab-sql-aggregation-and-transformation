-- ----------------------------------
-- Challenge 1
-- ----------------------------------

-- You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;
SELECT 
	MIN(length) AS min_duration,
	MAX(length) AS max_duration
FROM film;

-- Alternative approach
(SELECT
	title, length
FROM film
ORDER BY length DESC, title
LIMIT 1)
UNION ALL
(SELECT
	title, length
FROM film
ORDER BY length, title
LIMIT 1);

-- alternative approach with subquery
SELECT title, length
FROM (
    SELECT title, length
    FROM film
    ORDER BY length DESC, title
    LIMIT 1
) AS longest
UNION ALL
SELECT title, length
FROM (
    SELECT title, length
    FROM film
    ORDER BY length ASC, title
    LIMIT 1
) AS shortest;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals
-- Hint: Look for floor and round functions.
-- (FLOOR() rounds a number down to the nearest integer.
SELECT 
	FLOOR(AVG(length) /60) AS hours,
    ROUND(MOD(AVG(length), 60)) AS minutes
FROM film;


-- You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(
	MAX(rental_date),
	MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental.
-- Return 20 rows of results.
SELECT
	MONTH (rental_date) AS rental_month,
    DAYNAME (rental_date) AS rental_weekday
FROM rental
LIMIT 20;
    
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday',
-- depending on the day of the week. Hint: use a conditional expression.
SELECT rental_date,
CASE 
    WHEN DAYOFWEEK(rental_date) = 1 OR (rental_date) = 7
    THEN 'weekend'
	ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- 3. Retrieve the film titles and their rental duration.
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order. 
SELECT title,
	COALESCE (rental_duration, 'Not Available') AS rental_duration
    FROM film
    WHERE 1 = 1
    ORDER BY length ASC;
-- Hint: Look for the IFNULL() function.
-- ** IFNULL() is MySQL-specific, while COALESCE() works in all SQL databases.
SELECT title,
	IFNULL (rental_duration, 'Not Available') AS rental_duration
    FROM film
    WHERE 1 = 1
    ORDER BY length ASC;
    
-- 4 Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers.
-- To achieve this, you need to retrieve the concatenated first and last names of customers,
-- along with the first 3 characters of their email address, so that you can address them by their first name
-- and use their email address to send personalized recommendations.
-- The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT
	CONCAT(first_name, ' ', last_name) AS 'customer_name',
    SUBSTRING(email, 1, 3) AS email_prefix
FROM sakila.customer
ORDER BY last_name ASC;

-- ----------------------------------
-- Challenge 2
-- ----------------------------------

-- 1. Analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT 
	COUNT(film_id)
FROM film;

-- 1.2 The number of films for each rating.
SELECT rating,  -- **select func has parameter because need to show the col rating alongside the count.
	COUNT(film_id) AS count_of_films
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating,
	COUNT(film_id) AS count_of_films
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating,
	ROUND(AVG(length), 2) AS mean_film_duration
FROM film
GROUP BY rating
ORDER BY mean_film_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours
-- in order to help select films for customers who prefer longer movies.
SELECT rating,
	ROUND(AVG(length), 2) AS mean_film_duration
FROM film -- gathers the rows
GROUP BY rating
HAVING mean_film_duration > 120;  -- filters groups after aggregation: sees the aggregated AVG(length) and can filter correctly

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name
FROM actor
GROUP BY last_name  -- groups all actors with the same last name
HAVING COUNT(*) = 1; -- filters only the groups that contain exactly one actor