use sakila;


-- CHALLENGE 1

-- 1.1

SELECT 
  MAX(length) AS max_duration,
  MIN(length) AS min_duration
FROM film;



-- 1.2

WITH avg_len AS (
  SELECT AVG(length) AS m 
  FROM film
)
SELECT
  FLOOR(m/60) + IF(ROUND(MOD(m,60)) = 60, 1, 0) AS avg_hours,
  IF(ROUND(MOD(m,60)) = 60, 0, ROUND(MOD(m,60))) AS avg_minutes
FROM avg_len;



-- 2.1

SELECT 
  DATEDIFF(MAX(rental_date), MIN(rental_date)) + 1 AS operating_days
FROM rental;


-- 2.2

SELECT
  rental_id,
  rental_date,
  customer_id,
  staff_id,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date)   AS rental_weekday
FROM rental
ORDER BY rental_date
LIMIT 20;


-- 2.3 (bonus)

SELECT
  rental_id,
  rental_date,
  customer_id,
  staff_id,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date)   AS rental_weekday,
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'  -- 1=Sun, 7=Sat
    ELSE 'workday'
  END AS DAY_TYPE
FROM rental
ORDER BY rental_date
LIMIT 20;


-- 3

SELECT 
  title,
  IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- 4 

SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(IFNULL(email, ''), 3)         AS email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;


-- CHALLENGE 2

-- 1.1

SELECT COUNT(*) AS total_films
FROM film;


-- 1.2 

SELECT 
  rating,
  COUNT(*) AS film_count
FROM film
GROUP BY rating;


-- 1.3

SELECT 
  rating,
  COUNT(*) AS film_count
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

-- 3 BONUS 

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;
