USE sakila;

-- CHALLENGE 1
-- TASK 1

SELECT
  MIN(length) AS min_duration,
  MAX(length) AS max_duration
FROM film;

SELECT 
  FLOOR(AVG(length) / 60) AS avg_hours,
  ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- TASK 2
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

SELECT
  *,
  MONTH(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT
  *,
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
    ELSE 'workday'
  END AS DAY_TYPE
FROM rental
LIMIT 20;

-- TASK 3
SELECT
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT COUNT(*)
FROM film
WHERE rental_duration IS NULL;

-- TASK 4
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(email, 3) AS email_3
FROM customer
ORDER BY first_name ASC
LIMIT 100;

-- CHALLENGE 2
-- TASK 1

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- TASK 2

SELECT
  rating,
  ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

SELECT
  rating,
  ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_duration DESC;

-- TASK 3

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

SELECT COUNT(*) AS unique_last_name_count
FROM (
  SELECT last_name
  FROM actor
  GROUP BY last_name
  HAVING COUNT(*) = 1
) AS unique_names;