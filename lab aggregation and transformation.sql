-- chalenge 1--

USE sakila;

-- 1.1 --
SELECT 
  MIN(length) AS min_duration,
  MAX(length) AS max_duration
FROM film;

-- 1.2 --
SELECT 
  FLOOR(AVG(length) / 60) AS avg_hours,
  FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.1 --
SELECT 
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 --
SELECT 
  rental_id,
  rental_date,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus --
SELECT 
  rental_id,
  rental_date,
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
    ELSE 'workday'
  END AS day_type
FROM rental
LIMIT 20;

-- 3 --
SELECT 
  title,
  IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Bonus --
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(email, 3) AS email_prefix,
  email
FROM customer
ORDER BY last_name ASC;











