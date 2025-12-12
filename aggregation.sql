USE sakila;
SHOW TABLES;
-- Challenge 1
SELECT length FROM film
WHERE film_id = 1;
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;
-- 2.1 Calculate the number of days that the company has been operating.
SELECT * FROM rental;

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;
-- 3. 
-- You need to ensure that customers can easily access information about the movie collection.
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4 Bonus
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1 The total number of films that have been released.
SELECT COUNT(*) AS total_films
FROM film;
-- 1.2 The number of films for each rating.
SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating; 
-- 1.3 The number of films for each rating, 
-- sorting the results in descending order of the number of films. 
SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. 
-- This will help identify popular movie lengths for each category.
SELECT 
	rating,
	ROUND(AVG(length), 2) AS mean_film_duration
FROM film
GROUP BY rating
ORDER BY mean_film_duration DESC;
 -- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT 
	rating,
	ROUND(AVG(length), 2) AS mean_film_duration
FROM film 
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_film_duration DESC;
-- Bonus: determine which last names are not repeated in the table actor.
SELECT DISTINCT(last_name)
FROM actor;
