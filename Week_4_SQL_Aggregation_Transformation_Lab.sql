-- SQL Aggregation and Transformation Lab --

-- CHALLENGE 1 --
-- 1.1. The shortest and Longest movie durations
SELECT MIN(length) AS min_duration,
       MAX(length) AS max_duration
FROM film;

-- 1.2. The average movie duration in hours and minutes without decimals
SELECT FLOOR(AVG(length) / 60) AS avg_duration_hours,
       FLOOR(AVG(length) % 60) AS avg_duration_minutes
FROM film;

-- 2.1. The number of days that the company has been operating
SELECT DATEDIFF(CURDATE(), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2. Rental table with month and weekday new columns
SELECT *,
       MONTHNAME(rental_date) AS rental_month,
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Bonus 2.3.  Rental table with Day_type new column
SELECT *,
       CASE
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'Weekend' -- 1 = Sunday, 7 = Saturday
           ELSE 'Weekday'
       END AS day_type
FROM rental
LIMIT 20;

-- 3. Film titles and their rental duration with 'Not Available' for NULLs
SELECT title,
       rental_duration,
       IFNULL(rental_duration, 'Not Available') AS rental_duration_status
FROM film
ORDER BY rental_duration DESC, title ASC

-- 4. Customer full names and email prefixes
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
         LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- CHALLENGE 2 --
-- 1.1 The total number of films that have been released
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 / 1.3 The number of films for each rating
SELECT rating,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 The mean film duration for each rating
SELECT ROUND(AVG(length), 2) AS mean_film_duration,
       rating
FROM film
GROUP BY rating
ORDER BY mean_film_duration DESC;

-- 2.2 Ratings that have a mean duration of over two hours
SELECT rating,
       ROUND(AVG(length), 2) AS mean_film_duration
FROM film
GROUP BY rating
HAVING mean_film_duration > 120
ORDER BY mean_film_duration DESC;

-- Bonus 3. Last names are not repeated in the table actor
SELECT DISTINCT last_name
FROM actor
ORDER BY last_name ASC;