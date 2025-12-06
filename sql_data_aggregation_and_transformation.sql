USE sakila;
-- CHALLENGE 01
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM sakila.film;

-- 1.2 Express the average movie duration in hours and minutes.
SELECT FLOOR(AVG(length)/60) AS avg_hours,
ROUND(AVG(length)%60) AS avg_minutes
FROM sakila.film;

-- 2.1 Calculate the number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
-- Return 20 rows of results.
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, 
MONTHNAME(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM sakila.rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', 
-- depending on the day of the week.
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, 
CASE
	WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
    ELSE 'workday'
END AS day_type
FROM sakila.rental;

-- 3. Retrieve the film titles and their rental duration.If any rental duration value is NULL, 
-- replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

-- Bonus: Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address. 
-- The results should be ordered by last name in ascending order
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
SUBSTRING(email, 1, 3) AS email_prefix
FROM sakila.customer
ORDER BY last_name ASC;

-- CHALLENGE 02

-- 1. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(film_id)
FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2 Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;