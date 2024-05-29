USE sakila;

-- Challenge 1
-- 1. Duration of movies
-- 1.1 shortest and longest movie durations 
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration 
FROM film;

-- 1.2 average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60) AS avg_minutes 
FROM film;

-- 2. Rental dates
-- 2.1 number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days 
FROM rental;

-- 2.2 the month and weekday of the rental
SELECT 
    rental_id, 
    rental_date, 
    EXTRACT(MONTH FROM rental_date) AS rental_month, 
    DAYOFWEEK(rental_date) AS rental_weekday 
FROM rental 
LIMIT 20;

-- 2.3 Bonus: an additional column called DAY_TYPE with values 'weekend' or 'workday'
SELECT 
    rental_id, 
    rental_date, 
    EXTRACT(MONTH FROM rental_date) AS rental_month, 
    DAYOFWEEK(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental 
LIMIT 20;

-- 3. Retrieve the film titles and their rental duration. 
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film ORDER BY title ASC;

-- Bonus: Retrieve concatenated first and last names of customers, with the first 3 characters of their email address, ordered by last name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name, LEFT(email, 3) AS email_prefix 
FROM customer ORDER BY last_name ASC;

-- Challenge 2
-- 1. analyze the films in the collection
-- 1.1 The total number of films 
SELECT COUNT(*) AS total_films 
FROM film;
-- 1.2 The number of films for each rating
SELECT rating, COUNT(*) AS film_count 
FROM film GROUP BY rating;
-- 1.3 sorting the results in descending order of the number of films.alter
SELECT rating, COUNT(*) AS film_count 
FROM film GROUP BY rating ORDER BY film_count DESC;

-- 2. Using the film table
-- 2.1 The mean film duration for each rating 
SELECT rating, ROUND(AVG(length), 2) AS avg_duration 
FROM film GROUP BY rating ORDER BY avg_duration DESC;
-- 2.2 Identify which ratings have a mean duration of over two hours
SELECT rating FROM film 
GROUP BY rating HAVING AVG(length) > 120;

-- 3. Bonus: determine which last names are not repeated in the table actor 
SELECT last_name FROM actor 
GROUP BY last_name 
HAVING COUNT(last_name) = 1;

