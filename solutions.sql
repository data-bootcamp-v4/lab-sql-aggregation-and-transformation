USE sakila;

-- 1.
-- 1.1
SELECT 
  MIN(length) AS min_duration,
  MAX(length) AS max_duration
FROM film;

-- 1.2
SELECT
  CONCAT(
    FLOOR(AVG(length) / 60), 'h ',
    MOD(FLOOR(AVG(length)), 60), 'm'
  ) AS avg_duration_hm
FROM film;

-- 2.
-- 2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2
SELECT
  rental_id,
  rental_date,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date)   AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;

-- 2.3
SELECT
  rental_id,
  rental_date,
  DAYNAME(rental_date) AS rental_weekday,
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'   -- 1=Sunday, 7=Saturday
    ELSE 'workday'
  END AS day_type
FROM rental
ORDER BY rental_date
LIMIT 20;

-- 3.
SELECT
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4.
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name, first_name;


