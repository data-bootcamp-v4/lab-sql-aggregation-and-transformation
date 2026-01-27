USE sakila;

-- ACTIVIDAD 1.1

SELECT
MIN(length) AS min_duration, 
MAX(length) AS max_duration 
FROM film;

-- ACTIVIDAD 1.2

SELECT 
FLOOR(AVG(length) / 60) AS hours, 
ROUND(AVG(length) % 60) AS minutes 
FROM film;

-- ACTIVIDAD 2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS Días_operados 
FROM rental;

-- actividad 2.2

SELECT 
    rental_id, 
    rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday 
FROM sakila.rental 
LIMIT 20;

-- actividad 2.3
SELECT *, 
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'fin de semana'
        ELSE 'día laboral'
    END AS DAY_TYPE
FROM rental;

-- actividad 3--

SELECT 
    title, 
    IFNULL(rental_duration, 'No disponible') AS rental_duration
FROM film
ORDER BY title ASC;

-- Desafio 2
-- actividad 1.1
SELECT *
FROM film;

SELECT COUNT(*) AS total_estrenadas 
FROM film;

SELECT
rating,
COUNT(*) AS total_estrenadas
FROM film
group by rating;

-- actividad 1.3
SELECT 
rating,
COUNT(*) AS numero_de_peliculas
FROM film
GROUP BY rating
ORDER BY numero_de_peliculas DESC;

-- actividad 2.1

SELECT 
rating,
ROUND(AVG(length), 2) AS duracion_media 
FROM film 
GROUP BY rating 
ORDER BY duracion_media DESC;

-- actividad 2.2

SELECT 
rating,
ROUND(AVG(length), 2) AS duracion_media 
FROM film 
GROUP BY rating 
HAVING AVG(length) > 120;

-- actividad 3

SELECT 
last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;




