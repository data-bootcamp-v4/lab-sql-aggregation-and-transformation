-- LAB: SQL Data Aggregation and Transformation
-- Base de datos: Sakila

USE sakila;

Challenge 1

-- 1.1 Duración mínima y máxima de las películas

SELECT
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

-- 1.2 Duración media de las películas en horas y minutos

SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;

-- 2.1 Número de días que lleva funcionando la empresa

--- Su estructura es DATEDIFF(fecha_final, fecha_inicial)

Ejecución:

SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Consultar los alquileres y añadir el mes y el día de la semana

SELECT
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: Clasificar los alquileres entre fin de semana y día laborable

---Su estructura es CASE
    WHEN condicion THEN resultado
    ELSE otro_resultado
END

Ejecución:

SELECT
    *,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3. Obtener los títulos y la duración del alquiler de las películas

---Su estructura es IFNULL(rental_duration, 'Not Available')

Ejecución: 

SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. BONUS: Concatenar nombres y extraer los primeros caracteres del email

SELECT
    CONCAT(first_name, ' ', last_name) AS customer_name,
    SUBSTRING(email, 1, 3) AS email_start
FROM customer
ORDER BY last_name ASC;

---Challege 1 terminada

-- CHALLENGE 2
-- 1.1 Número total de películas

SELECT
    COUNT(*) AS total_films
FROM film;

-- 1.2 Número de películas para cada clasificación

SELECT
    rating,
    COUNT(*) AS total_films
FROM film
GROUP BY rating;

-- 1.3 Número de películas por clasificación, ordenadas de mayor a menor

SELECT
    rating,
    COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

-- 2.1 Duración media de las películas por clasificación

SELECT
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 Clasificaciones con una duración media superior a 120 minutos

SELECT
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- 3. BONUS: Apellidos de actores que no están repetidos

SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

