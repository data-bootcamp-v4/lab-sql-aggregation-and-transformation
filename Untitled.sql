USE sakila;
-- 1:
SELECT MAX(length) AS max_duration, MIN(length) as min_duration FROM film;
SELECT CONCAT(FLOOR(AVG(length) / 60), ':', LPAD(FLOOR(AVG(length) % 60), 2, '0')) AS average_duration FROM film;
-- 2:
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days FROM rental;
SELECT 
    rental_id,
    customer_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- 3:

SELECT COALESCE(title, 'Not Available') AS title, rental_duration
FROM film;

-- Challenge 2, 1:
SELECT COUNT(film_id) FROM film;
SELECT DISTINCT rating FROM film;
SELECT COUNT(film_id) FROM film WHERE rating = 'PG';
SELECT COUNT(film_id) FROM film WHERE rating = 'G';
SELECT COUNT(film_id) FROM film WHERE rating = 'NC-17';
SELECT COUNT(film_id) FROM film WHERE rating = 'PG-13';
SELECT COUNT(film_id) FROM film WHERE rating = 'R';

SELECT rating, COUNT(film_id) AS rating_count
FROM film
GROUP BY rating
ORDER BY rating_count DESC;
-- 2:
SELECT ROUND(AVG(length), 2), rating AS average_length
FROM film
GROUP BY rating
ORDER BY average_length DESC;

SELECT rating, AVG(length) AS avg_length FROM film
GROUP BY rating
HAVING AVG(length) > 120;




