USE sakila;

-- 1. Challenge #1
-- 1.1 Duración min y max de las peliculas
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
-- 1.2 Duración media en horas y minutos
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length)) - FLOOR(AVG(length) / 60) * 60 AS avg_minutes
FROM film;

-- 2. Insight de rental
-- 2.1 Días que lleva operando la empresa
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
-- 2.2 Info de alquileres con mes y dia de la semana
SELECT *,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- 2.3 Bonus, tipo de día: fin de semana y día laborable
SELECT *,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- 3. Titulos y duración de alquiler, NULL reemplazado por 'Not available'
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. bonus
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1 Total peliculas lanzadas
SELECT COUNT(*) AS total_films
FROM film;
-- 1.2 Numero peliculas por clasificacion
SELECT 
    rating,
    COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating;
-- 1.3 Peliculas por clasificacion ordenadas de forma descendente
SELECT 
    rating,
    COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Duracion media por clasificacion ordenada de mayor a menor
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
-- 2.2 Clasificacion con duracion media mayor de 120 min
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

-- 3. bonus
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;