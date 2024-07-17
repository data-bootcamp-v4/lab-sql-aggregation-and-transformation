USE sakila;
-- Challenge 1: Insights on Movie Durations and Rental Dates
-- 1.1 Determine the shortest and longest movie durations:
SELECT
  MIN(length) AS min_duration,
  MAX(length) AS max_duration
FROM film;
-- 1.2 Express the average movie duration in hours and minutes:
SELECT
  FLOOR(AVG(length) / 60) AS hours,
  ROUND(AVG(length) % 60) AS minutes
FROM film;
-- 2.1 Calculate the number of days the company has been operating:
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operated
FROM rental;
-- 2.2 Retrieve rental information with month and weekday:
SELECT
  rental_id,
  rental_date,
  MONTH(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- 2.3 Retrieve rental information with DAY_TYPE:
SELECT
  rental_id,
  rental_date,
  CASE WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' ELSE 'workday' END AS DAY_TYPE
FROM rental
LIMIT 20;
-- 2.4 Retrieve film titles, rental duration, and handle NULLs:
SELECT
  f.title,
  IFNULL(r.rental_duration, 'Not Available') AS rental_duration
FROM film f
LEFT JOIN rental r ON f.film_id = r.film_id
ORDER BY f.title ASC;
-- Bonus: Concatenated customer names and email prefixes:
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;
-- Challenge 2: Analyzing Film Data
-- 1.1 Total number of films:
SELECT COUNT(*) AS total_films
FROM film;
-- 1.2 Number of films for each rating:
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;
-- 1.3 Number of films for each rating, sorted descending:
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;
-- 2.1 Mean film duration for each rating:
SELECT
  rating,
  ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;
-- 2.2 Ratings with mean duration over two hours:
SELECT rating
FROM film
GROUP BY rating
HAVING AVG(length) > 120;
-- Bonus: Last names without duplicates:
SELECT DISTINCT last_name
FROM actor;