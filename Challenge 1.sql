USE sakila;
SELECT 
  MIN(length) AS min_duration,
  MAX(length) AS max_duration
FROM film;
SELECT
  FLOOR(AVG(length) / 60) AS avg_hours,
  (ROUND(AVG(length)) - 60 * FLOOR(AVG(length) / 60)) AS avg_minutes
FROM film;
SELECT 
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
SELECT 
  rental_id,
  rental_date,
  DATE_FORMAT(rental_date, '%M') AS rental_month,
  DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;
SELECT 
  rental_id,
  rental_date,
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
    ELSE 'workday'
  END AS day_type
FROM rental
ORDER BY rental_date
LIMIT 20;
SELECT 
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  SUBSTRING(email, 1, 3)           AS email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;
