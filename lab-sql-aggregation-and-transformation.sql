USE sakila;

-- Challenge
-- 1
Use sakila;

-- 1.1
SELECT MAX(length) as 'max_duration', MIN(length) as 'min_duration' FROM sakila.film;
-- 1.2 
SELECT ROUND(AVG(length)) FROM sakila.film;

-- 2
-- 2.1
SELECT rental_date FROM sakila.rental;

-- 2.2 
SELECT *, DATE_FORMAT(CONVERT(rental_date, DATE), '%M') as 'Month',DATE_FORMAT(CONVERT(rental_date, DATE), '%D') as 'Day' FROM sakila.rental limit  20;

-- 3

SELECT title, rental_duration FROM sakila.film WHERE ISNULL(rental_duration) = "Not Available" ;


-- Cahellenge
-- 1
-- 1.1
SELECT COUNT(*) from sakila.film;
-- 1.2 
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;


-- 2
-- 2.1
SELECT rating, ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

-- 2.2
SELECT rating, ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_duration DESC;
