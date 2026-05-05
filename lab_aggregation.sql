USE sakila;

-- Challenge 1
-- 1) Shortest and longest movies, aliased
SELECT
MIN(length) AS min_duration,
MAX(length) AS max_duration
FROM film;

-- 1.2) Average movie duration in hours and minutes, no decimals
SELECT 
FLOOR(AVG(length) / 60) AS hours, 
ROUND(AVG(length) % 60) AS minutes
FROM film;

-- 2.1) Calculate number of days that the company has been operating
SELECT 
MIN(rental_date) AS 'First day',
MAX(rental_date) AS 'Last day to date',
DATEDIFF(MAX(rental_date), MIN(rental_date)) AS 'Operating days'
FROM rental;

-- 2.2) Rental information and add two additional columns for the month and weekday of the rental, limit 20
SELECT 
MONTHNAME(rental_date) AS rental_month, 
DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3) Bonus: Additional column called DAY_TYPE for weekends or weekdays
SELECT rental_date,
DAYNAME(rental_date) AS day_name,
CASE 
WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
ELSE 'workday'
END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3) Movie titles and their rental duration, if rental is null replace for 'not available'. Title by ASC
SELECT title, IFNULL(rental_duration, 'Not available') AS rental_duration
FROM film
ORDER BY title ASC;


-- 4) Challenge 1 - Bonus: 
-- Concatenated first and last names of customers, along with first 3 characters of their email addresses. Order ASC
SELECT CONCAT(first_name, ' ', last_name) AS 'Customer',
LEFT(email, 3) AS 'First 3 from email'
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1 Total number of films released
SELECT COUNT(*) AS total_films FROM film;

-- 1.2 Determine number of films for each rating
SELECT rating, COUNT(rating) AS film_rating
FROM film
GROUP BY rating;

-- 1.3 Determine number of films for rating - DESC
SELECT rating, COUNT(rating) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2.1 Mean duration per rating, sorted DESC
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with mean duration over 2 hours
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;

-- Bonus: 3) Determine which last names are not repeated
SELECT last_name, COUNT(last_name) AS count
FROM actor
GROUP BY last_name
HAVING count = 1
ORDER BY last_name ASC;