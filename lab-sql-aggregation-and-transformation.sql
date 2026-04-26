-- CHALLENGE 1

USE sakila; 

-- 1. insights relating to the duration of movies
-- 1.1 shortest and longest movie durations
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration 
FROM film;

-- 1.2 average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60) AS avg_minutes 
FROM film;

-- 2. rental dates
-- 2.1 number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating 
FROM rental;

-- 2.2. month and weekday of the rental.
SELECT *, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday 
FROM rental 
LIMIT 20;

-- 2.3.  'weekend' or 'workday',
SELECT *, 
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

-- 3. retrieve the film titles and their rental duration
SELECT title, 
       IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film 
ORDER BY title ASC;

-- 4.  concatenated first and last names of customers,
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- CHALLENGE 2
-- 1. analize films
-- 1.1. total number of films
SELECT COUNT(*) AS total_films 
FROM film;

-- 1.2.  number of films for each rating.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3.  number of films for each rating, sorting
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2. analize the films
-- 2.1. mean film duration for each rating
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2. which ratings have a mean duration of over two hours
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;