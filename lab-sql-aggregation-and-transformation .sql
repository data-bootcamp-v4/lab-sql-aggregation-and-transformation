use sakila;

SELECT
MIN(length) AS min_duration,
MAX(length) AS max_duration 
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

SELECT
FLOOR(AVG(length)/60) AS avg_hours,
ROUND(AVG(length)/60) AS avg_mins
FROM film;

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT 
DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental.
-- Return 20 rows of results.

SELECT rental_date,
month(rental_date),
day(rental_date)
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT
rental_id,
rental_date,
DAYNAME(rental_date) AS dia_semana,
CASE
WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
ELSE 'workday'
END AS DAY_TYPE
FROM
rental
LIMIT 20;

-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration.
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT 
title,
IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- CHALLENGE 2 
-- 1.1 The total number of films that have been released.

SELECT
COUNT(*)
FROM film;

-- 1.2 The number of films for each rating.
SELECT 
rating,
COUNT(film_id) AS movie_number
FROM film
GROUP BY
rating;


-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 


SELECT 
  rating,
  COUNT(film_id) AS movie_number
FROM film
GROUP BY rating
ORDER BY movie_number DESC;


-- 2.1 Using the film table, determine: The mean film duration for each rating, and sort the results in descending order of the mean duration.
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT 
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT 
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- 3. Bonus: determine which last names are not repeated in the table actor.

SELECT 
  last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;



