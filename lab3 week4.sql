USE sakila;

-- ------------
-- Challenge 1
-- ------------
SELECT
  MAX(length) AS max_duration,
  MIN(length) AS min_duration
FROM film;

SELECT
  FLOOR(AVG(length) / 60) AS avg_hours,
  FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

SELECT
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

SELECT
  rental_id,
  rental_date,
  MONTHNAME(rental_date) AS rental_month,
  DAYNAME(rental_date)   AS rental_weekday,
  inventory_id,
  customer_id,
  staff_id
FROM rental
ORDER BY rental_date
LIMIT 20;

SELECT
  rental_id,
  rental_date,
  DAYNAME(rental_date) AS rental_weekday,
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

-- =========================
-- Challenge 2 (counts)
-- =========================

-- 1.1 Total number of films released
SELECT COUNT(*) AS total_films FROM film;

-- 1.2 Number of films for each rating
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY rating;

-- 1.3 Number of films for each rating, sorted by film_count desc
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC, rating;

-- ============
-- Challenge 2
-- ============

SELECT
  rating,
  ROUND(AVG(length), 2) AS avg_length_minutes
FROM film
GROUP BY rating
ORDER BY avg_length_minutes DESC;

SELECT
  rating,
  ROUND(AVG(length), 2) AS avg_length_minutes
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_length_minutes DESC;
