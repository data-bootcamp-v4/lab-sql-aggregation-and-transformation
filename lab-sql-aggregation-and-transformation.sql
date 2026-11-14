USE sakila;
SHOW TABLES;

-- CHALLENGE 1.


-- 1.1.
DESCRIBE film;
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;

-- 1.2.
SELECT ROUND(AVG(length)) FROM film;
SELECT
FLOOR(ROUND(AVG(length)) / 60) AS hours,
MOD(ROUND(AVG(length)),  60) AS minutes
FROM film;

-- 2.1.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating FROM rental;

-- 2.2.
SELECT *, MONTHNAME(rental_date) AS month, WEEKDAY(rental_date) AS weekday FROM rental LIMIT 20;

-- 2.3.
SELECT *,
  CASE
    WHEN WEEKDAY(rental_date) IN (5, 6) THEN 'weekend'
    ELSE 'workday'
  END AS DAY_TYPE
FROM rental;

-- 3.
SELECT title , IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4.
SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  SUBSTRING(email, 1, 3) AS email_start
FROM customer
ORDER BY last_name ASC;


-- CHALLENGE 2.

-- 1.1.
SELECT COUNT(*) AS total_films FROM film;

-- 1.2.
SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating;

-- 1.3.
SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

-- 2.1.
SELECT rating, ROUND(AVG(length),2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2.
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- 3.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;