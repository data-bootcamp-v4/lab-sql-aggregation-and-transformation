-- chalenge 2 --
USE sakila;

-- 1 --
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 --
SELECT 
  rating,
  COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 --
SELECT 
  rating,
  COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2 --
SELECT 
  rating,
  ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 --
SELECT 
  rating,
  ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Bonus --
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
