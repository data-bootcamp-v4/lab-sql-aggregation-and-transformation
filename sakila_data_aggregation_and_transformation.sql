-- Lab | SQL Data Aggregation and Transformation (SAKILA - MySQL)
-- ---------------------------------------------------------------
-- General notes about the schema:
-- - film.length represents the movie duration in minutes
-- - film.rental_duration represents the rental duration in days
-- - rental.rental_date stores the date and time of each rental
-- ----------------------------------------------------------------

-- CHALLENGE 1 --------------------------------
-- ------------------------------------------------------------------
-- 1. Movie duration insights (table: film)
-- ------------------------------------------------------------ 

-- 1.1 Find the shortest and longest movie durations.
-- - MAX(length) returns the longest movie duration
-- - MIN(length) returns the shortest movie duration
-- - Aliases are used to make the output easier to read 
SELECT
  MAX(length) AS max_duration,
  MIN(length) AS min_duration
FROM film;


-- 1.2 Calculate the average movie duration expressed in -------
-- - hours and minutes (no decimals).
-- Explanation:
-- - AVG(length) returns the average duration in minutes (can be decimal)
-- - Hours are calculated by dividing by 60 and using FLOOR
-- - Remaining minutes are calculated using MOD and FLOOR */
SELECT
  FLOOR(AVG(length) / 60) AS avg_hours,
  FLOOR(MOD(AVG(length), 60)) AS avg_minutes
FROM film;


-- 2. Rental date insights (table: rental)
-- ---------------------------------------------------

-- 2.1 Calculate how many days the company has been operating. ---------
-- - DATEDIFF subtracts the earliest rental date

-- from the latest rental date 
SELECT
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;


-- 2.2 Retrieve rental information and add:
-- - The month name of the rental
--- - The weekday name of the rental
-- Only 20 rows are returned for readability 
SELECT
  rental_id,
  rental_date,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;


-- 2.3 BONUS: Add a column called DAY_TYPE.
-- - 'weekend' if the rental happened on Saturday or Sunday
-- - 'workday' otherwise --

-- Notes:
-- - DAYOFWEEK() in MySQL returns:
-- 1 = Sunday, 7 = Saturday
-- - CASE is used to apply conditional logic 

SELECT
  rental_id,
  rental_date,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday,
  CASE
    WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
    ELSE 'workday'
  END AS DAY_TYPE
FROM rental
LIMIT 20;


-- 3. Movie catalog: titles and rental duration (NULL handling)
-- ------------------------------------------------------------ 

-- Requirements:
-- - Retrieve movie titles and their rental duration
-- - Replace NULL rental_duration values with 'Not Available'
-- - Sort results alphabetically by title

-- Notes:
-- - IFNULL handles possible NULL values
-- - rental_duration is numeric, so it is cast to CHAR to allow text 

SELECT
title,
IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- BONUS: Marketing use case – customer name and email prefix
-- ------------------------------------------------------------ 
-- Requirements:
-- - Concatenate first name and last name into one column
-- - Extract the first 3 characters of the email address
-- - Sort results by last name (and first name for consistency) 

SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;

-- --------------------------------------------------------------------------
-- CHALLENGE 2 --------------------
-- -------------------------------------

-- 1. Film counts by rating (table: film)
-- ------------------------------------------------------------ 

-- 1.1 Calculate the total number of films in the database -------

SELECT
  COUNT(*) AS total_films
FROM film;


-- 1.2 Count how many films exist for each rating --

SELECT
  rating,
  COUNT(*) AS film_count
FROM film
GROUP BY rating;


-- 1.3 Count films per rating and sort the result
-- from highest to lowest number of films 

SELECT
  rating,
  COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;


-- 2. Average movie duration by rating
-- ------------------------------------------------------------ 

-- 2.1 Calculate the mean movie duration (in minutes) for each rating.
-- - Results are rounded to two decimal places
-- - Output is sorted by average duration (descending) 

SELECT
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;


-- 2.2 Identify ratings with an average duration longer than 2 hours.
-- - 2 hours = 120 minutes
-- - HAVING is used because we filter on an aggregate value 

SELECT
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- -----------------------------------------------------------
-- BONUS: Find actor last names that are not repeated
-- ------------------------------------------------------------ 

-- Requirements:
-- - Identify last names that appear only once in the actor table
-- - GROUP BY is used together with HAVING to filter unique values 

SELECT
  last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;


