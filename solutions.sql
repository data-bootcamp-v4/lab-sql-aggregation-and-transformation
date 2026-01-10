-- solutions.sql
-- SQL Data Aggregation and Transformation Lab (Sakila)

USE sakila;

-- Challenge 1

-- 1.1 Determine the shortest and longest movie durations
-- NOTE: prompt says "name the values as max_duration and min_duration"
SELECT
  MAX(length) AS max_duration,
  MIN(length) AS min_duration
FROM film;

-- 1.2 Express the average movie duration in hours and minutes (no decimals)
-- Average minutes -> hours + remaining minutes
SELECT
  FLOOR(AVG(length) / 60) AS avg_duration_hours,
  ROUND(AVG(length) - (FLOOR(AVG(length) / 60) * 60)) AS avg_duration_minutes
FROM film;

-- 2.1 Calculate the number of days the company has been operating
SELECT
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Retrieve rental info + month and weekday, 20 rows
SELECT
  rental_id,
  rental_date,
  inventory_id,
  customer_id,
  staff_id,
  return_date,
  MONTH(rental_date) AS rental_month,
  WEEKDAY(rental_date) AS rental_weekday  -- 0=Mon ... 6=Sun
FROM rental
ORDER BY rental_date
LIMIT 20;

-- 2.3 BONUS: Add DAY_TYPE = 'weekend' or 'workday'
-- WEEKDAY(): 5=Sat, 6=Sun
SELECT
  rental_id,
  rental_date,
  inventory_id,
  customer_id,
  staff_id,
  return_date,
  MONTH(rental_date) AS rental_month,
  WEEKDAY(rental_date) AS rental_weekday,
  CASE
    WHEN WEEKDAY(rental_date) IN (5, 6) THEN 'weekend'
    ELSE 'workday'
  END AS day_type
FROM rental
ORDER BY rental_date
LIMIT 20;

-- 3) Film titles + rental duration, replace NULL with 'Not Available', sort title asc
SELECT
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- BONUS: Marketing email campaign
-- Concatenate first + last name, and first 3 characters of email
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;

-- Challenge 2

-- 1.1 Total number of films released
SELECT
  COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films for each rating
SELECT
  rating,
  COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating, sorted desc by count
SELECT
  rating,
  COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2.1 Mean film duration for each rating (rounded to 2 decimals), sorted desc by mean duration
SELECT
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with mean duration over two hours (> 120 minutes)
SELECT
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- BONUS: Determine which last names are not repeated in actor table
SELECT
  last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;
