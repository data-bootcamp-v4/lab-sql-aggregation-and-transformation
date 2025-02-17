USE sakila;
-- 1.
SELECT MAX(length) as max_duration, MIN(length) as min_duration from film;
--
SELECT 
    (AVG(length) DIV 60) AS avg_hours, 
    (ROUND(AVG(length) MOD 60, 0)) AS avg_minutes
FROM film;
-- 2.
SELECT * from rental;
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) as days_open from rental;
-- 266 days
SELECT *, DATE_FORMAT(rental_date , '%M') as rental_month, DATE_FORMAT(rental_date , '%W') as week_day from rental
limit 20;
--
SELECT title, 
       IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film;
-- Challenge 2
SELECT 
	count(DISTINCT film_id) as total_films
FROM film;
-- 
SELECT 
	count(DISTINCT film_id) as total,
    rating
FROM film
GROUP BY rating;
--
SELECT 
	count(DISTINCT film_id) as total,
    rating
FROM film
GROUP BY rating
ORDER BY total DESC;
--
SELECT
	ROUND(AVG(length),2) as avg_length,
    rating
FROM film
GROUP BY rating
ORDER by avg_length desc;
--
SELECT
	ROUND(AVG(length),2) as avg_length,
    rating
FROM film
GROUP BY rating
HAVING avg_length > 120;