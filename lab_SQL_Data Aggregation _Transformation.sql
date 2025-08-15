USE sakila;

-- Challenge 1
-- 1.1 Shortest and longest movie durations
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes 
SELECT
  FLOOR(AVG(length) / 60) AS avg_hours,
  FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.1 Number of days that the company has been operating
SELECT 
  DATEDIFF(
    MAX(rental_date),
    MIN(rental_date)
  ) AS operating_days
FROM rental;

-- 2.2 Month and weekday of the rental
SELECT
  rental_id,
  rental_date,
  inventory_id,
  customer_id,
  staff_id,
  MONTH(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus : 'weekend' or 'workday'
SELECT
  rental_id,
  rental_date,
  inventory_id,
  customer_id,
  staff_id,
  DAYNAME(rental_date) AS rental_weekday,
  CASE
    WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'  -- 1 = dimanche, 7 = samedi
    ELSE 'workday'
  END AS DAY_TYPE
FROM rental
LIMIT 20;


-- 3
SELECT
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Bonus 
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- Challenge 2 
-- 1.1 Total number of films 
SELECT COUNT(*) FROM film;

-- 1.2 Number of films for each rating 
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY rating;

-- 1.3
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;


-- 2.1 
SELECT
  rating,
  ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 
SELECT
  rating,
  ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_duration DESC;

-- 3 Bonus 
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

