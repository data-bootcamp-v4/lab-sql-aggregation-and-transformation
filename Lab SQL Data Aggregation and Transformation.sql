#1
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS horas,
    FLOOR(AVG(length)) % 60 AS minutos
FROM film;

#2 
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS dias_operando
FROM rental;

SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS mes,
    DAYNAME(rental_date) AS dia_semana
FROM rental
LIMIT 20;

SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS dia_semana,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'fin de semana'
        ELSE 'día laboral'
    END AS day_type
FROM rental
LIMIT 20;

SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS dia_semana,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'fin de semana'
        ELSE 'día laboral'
    END AS day_type
FROM rental
LIMIT 20;

#3
SELECT 
    title,
    IFNULL(rental_duration, 'No disponible') AS duracion_alquiler
FROM film
ORDER BY title ASC;

#4
SELECT 
    first_name,
    last_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

#2#DESAFIO

SELECT COUNT(*) AS total_peliculas
FROM film;

SELECT rating, COUNT(*) AS cantidad
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS cantidad
FROM film
GROUP BY rating
ORDER BY cantidad DESC;

SELECT 
    rating,
    ROUND(AVG(length), 2) AS duracion_promedio
FROM film
GROUP BY rating
ORDER BY duracion_promedio DESC;

SELECT 
    rating,
    ROUND(AVG(length), 2) AS duracion_promedio
FROM film
GROUP BY rating
HAVING duracion_promedio > 120
ORDER BY duracion_promedio DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;


