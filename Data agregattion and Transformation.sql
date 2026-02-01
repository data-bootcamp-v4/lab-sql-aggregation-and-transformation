USE sakila;

-- Duracion minima y maxima de las peliculas
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

-- Duracion promedio de pelis en horas y minutos sin decimales
SELECT 
    FLOOR(AVG(length) / 60) AS horas,
    FLOOR(MOD(AVG(length), 60)) AS minutos
FROM film;

-- Los dias que la empresa ha estado operando
SELECT 
    DATEDIFF(
        MAX(rental_date),
        MIN(rental_date)
    ) AS dias_de_operacion
FROM rental;

-- añadir 2 columnas extras con dia de la semana de alquiler, mostrar 20 filas 
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    MONTH(rental_date) AS mes,
FROM rental,
LIMIT 20;

-- culumna day tipe con case
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20

-- con IFNULL()
SELECT 
    title AS film_title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film


-- campaña de email de masrketing
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


--- CHALLENGE 2 ---
-- Analisis de coleccion de peliculas 

-- Total de pelis publicadas
SELECT COUNT(*) AS total_films
FROM film;

-- Peliculas por rating
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- Peliculas por claseificacion de mayor a menor 
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- Media de las perliculas por rating
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- Peliculas con media superior a dos horas
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Apellidos que no se repiten
SELECT last_name
FROM actor


