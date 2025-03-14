USE sakila;

-- 1.1
SELECT * FROM film;
SELECT MAX(length) AS max_duration,
	   MIN(length) AS min_duration
FROM sakila.film;

-- 1.2
SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM sakila.film;

-- 2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_number_days
FROM rental;

-- 2.2
SELECT *,
	DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;

-- 3
SELECT title,
	   IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title;

-- 1.1 
SELECT * FROM film;
SELECT COUNT(DISTINCT title) AS total_released_films
FROM film;

-- 1.2
SELECT rating, COUNT(film_id) AS total_of_film_ratings
FROM film
GROUP BY rating;

-- 1.3
SELECT rating, COUNT(film_id) AS number_of_film_ratings
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

-- 2.1 
SELECT DISTINCT rating,
	ROUND(AVG(rental_duration) OVER (PARTITION BY rating), 2) AS average_rental_duration
FROM film
ORDER BY average_rental_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT DISTINCT rating, AVG(length) OVER(PARTITION BY rating) AS mean_over_2h
FROM film
WHERE length > 120;
