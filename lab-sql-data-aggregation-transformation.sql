-- LAB | SQL Data Aggregation and Transformation
-- Base de datos: Sakila

USE sakila;

-- ==========================================================
-- CHALLENGE 1
-- ==========================================================

-- 1.1 Duración máxima y mínima de las películas
SELECT MAX(length) AS max_duration,
       MIN(length) AS min_duration
FROM film;

-- 1.2 Duración media en horas y minutos, sin decimales
SELECT FLOOR(avg_minutes / 60) AS hours,
       avg_minutes % 60        AS minutes
FROM (
    SELECT ROUND(AVG(length)) AS avg_minutes
    FROM film
) AS t;

-- 2.1 Número de días que la empresa lleva operando
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Información de alquileres con mes y día de la semana (20 filas)
SELECT *,
       MONTHNAME(rental_date) AS rental_month,
       DAYNAME(rental_date)   AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: columna DAY_TYPE con 'weekend' o 'workday'
SELECT *,
       CASE
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3. Títulos y duración de alquiler (NULL -> 'Not Available'), orden ascendente por título
SELECT title,
       IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. BONUS: nombre completo del cliente y primeros 3 caracteres del email,
--    ordenado por apellido
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       SUBSTRING(email, 1, 3)             AS email_start
FROM customer
ORDER BY last_name ASC;

-- ==========================================================
-- CHALLENGE 2
-- ==========================================================

-- 1.1 Número total de películas
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 Número de películas por clasificación (rating)
SELECT rating,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Número de películas por rating, orden descendente por cantidad
SELECT rating,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Duración media por rating (2 decimales), orden descendente por la media
SELECT rating,
       ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings con duración media superior a 2 horas (120 minutos)
SELECT rating,
       ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- 3. BONUS: apellidos de actores que no se repiten
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
