USE sakila;
SHOW TABLES;

SELECT *
FROM film;

SELECT
MAX(length) AS max_duration,
MIN(length) AS min_duration
FROM film;

SELECT
ROUND(AVG(length)) AS average_movie_duration
FROM film;

SELECT
FLOOR(AVG(length) / 60) AS hours_average_duration,
ROUND(AVG(length)) AS mins_average_duration
FROM film;

SELECT *
FROM rental;

SELECT
DATEDIFF(
MAX(rental_date),
MIN(rental_date)
) AS days_operating
FROM rental;


SELECT *
FROM rental;

SELECT
rental_date,
MONTHNAME(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_day
FROM rental
LIMIT 20;

SELECT
rental_date,
CASE
	WHEN DAYNAME(rental_date) = 'Saturday' THEN "weekend"
    WHEN DAYNAME(rental_date) = 'Sunday' THEN "weekend"
    ELSE "workday"
    END AS day_type
FROM rental;


SELECT
title,
rental_duration,
IFNULL(rental_duration, "Not Available") AS corrected_rental_duration
FROM film
ORDER BY
title ASC;


SELECT *
FROM customer;

SELECT
first_name,
last_name,
email,
CONCAT(first_name, '  ', last_name) AS full_name
FROM customer
ORDER BY last_name ASC;



SELECT *
FROM film;

SELECT
COUNT(DISTINCT title) AS total_num_films
FROM film;

SELECT
rating,
COUNT(title) AS num_films
FROM film
GROUP BY rating;


SELECT
rating,
COUNT(title) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

SELECT
rating,
AVG(length) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;


SELECT
rating,
AVG(length) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;


SELECT *
FROM actor;

SELECT
last_name,
COUNT(actor_id) AS total
FROM actor
GROUP BY last_name
HAVING total = 1;
