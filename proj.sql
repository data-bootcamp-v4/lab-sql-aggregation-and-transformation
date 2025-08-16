-- (Optional)
USE sakila;

SELECT 
  MIN(length) AS min_duration,
  MAX(length) AS max_duration
FROM film;

-- Round the average to the nearest whole minute, then split into H/M
SELECT 
  FLOOR(ROUND(AVG(length)) / 60) AS avg_hours,
  MOD(ROUND(AVG(length)), 60)     AS avg_minutes
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT 
  rental_id,
  rental_date,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date)   AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;

SELECT 
  rental_id,
  rental_date,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date)   AS rental_weekday,
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'   -- 1=Sun, 7=Sat
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
  LEFT(email, 3)                     AS email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS n_films
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS n_films
FROM film
GROUP BY rating
ORDER BY n_films DESC;

SELECT 
  rating,
  ROUND(AVG(length), 2) AS mean_length_minutes
FROM film
GROUP BY rating
ORDER BY mean_length_minutes DESC;


SELECT 
  rating,
  ROUND(AVG(length), 2) AS mean_length_minutes
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_length_minutes DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;








