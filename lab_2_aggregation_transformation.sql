-- SQL Basic Queries Lab
-- Dataset: Sakila database
-- Author: Bryan Calderon

USE sakila;

# ========================= #
# Challenge 1
# ========================= #

-- 1.
-- 1.1 Shortest and longest movie durations and rename them
SELECT * FROM film;
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes (without decimals)
SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2. 
-- 2.1 Number of days the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Rental information with month and weekday (20 rows)
SELECT rental_id, rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 3. Film titles and rental duration, replacing NULL values ## This one, I am not sure at all ## 
SELECT title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. Bonus: Customer full name + first 3 characters of email
SELECT
	CONCAT(first_name, "", last_name) AS customer_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

# ========================= #
# Challenge 2
# ========================= #

-- 1.1 Total number of released films
SELECT COUNT(*) AS total_films_released
FROM film;

-- 1.2 Number of films for each rating
SELECT * FROM film;
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating, descending order
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Mean film duration for each rating, descending order
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with mean duration over two hours
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- Bonus: Last names not repeated in actor table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;