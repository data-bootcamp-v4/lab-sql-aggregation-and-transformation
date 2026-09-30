USE sakila;

-- DESAFIO 1
-- EJERCICIO 1
-- ejercicio 1.1
SELECT
MIN(length) AS min_duration,
MAX(length) AS max_duration
FROM film;

-- ejercicio 1.2
SELECT
ROUND(AVG(length)/60) AS avg_hours,
FLOOR(AVG(length)) AS avg_minutes
FROM film;

-- EJERCICIO 2
-- ejercicio 2.1
SELECT
DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- ejercicio 2.2
SELECT *,
MONTHNAME(rental_date) AS  rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- ejercicio 2.3
SELECT *,
DAYNAME(rental_date),
CASE
    WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
    ELSE 'workday'
END AS DAY_TYPE
FROM rental;

-- EJERCICIO 3
SELECT
title,
IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY
title ASC;

-- EJERCICIO 4
SELECT
first_name,
last_name,
LEFT(email, 3)
FROM customer
ORDER BY
last_name ASC;


-- DESAFIO 2
-- EJERCICIO 1
-- EJERCICIO 1.1
SELECT
COUNT(film_id) AS total_film
FROM film;

-- EJERCICIO 1.2
SELECT
rating,
COUNT(film_id) AS total_film
FROM film
GROUP BY
rating;

-- EJERCICIO 1.3
SELECT
rating,
COUNT(film_id) AS total_film
FROM film
GROUP BY
rating
ORDER BY
total_film DESC;

-- EJERCICIO 2
-- ejercicio 2.1
SELECT
rating,
ROUND(AVG(length), 2) AS duracion_promedio
FROM film
GROUP BY
rating
ORDER BY
duracion_promedio DESC;

-- ejercicio 2.2
SELECT
rating,
ROUND(AVG(length), 2) AS duracion_promedio
FROM film
GROUP BY
rating
HAVING AVG(length) > 120;


-- EJERCICIO 3
SELECT
last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;

























































