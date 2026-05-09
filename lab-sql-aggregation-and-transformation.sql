-- challenge 1
USE sakila;
-- 1.1
SELECT
MAX(length) as max_duration,
MIN(length) as min_duration
from film;
-- 1.2
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;
-- 2.1
SELECT
DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
-- 2.2
SELECT
MONTHNAME(rental_date) as rental_month,
DAYNAME(rental_date) as rental_weekday
from rental
limit 20;
-- 3
SELECT
title, 
IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film 
ORDER BY title ASC;

-- challenge 2 
-- 1.1 Total number of films released
SELECT 
    COUNT(*) AS total_films
FROM sakila.film;
 --
 -- 1.2
 SELECT 
 rating,
 COUNT(*) AS number_of_films
 from film
 group by rating;
 
 -- 1.3
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;
-- 2.1
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2
SELECT rating,
ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;
