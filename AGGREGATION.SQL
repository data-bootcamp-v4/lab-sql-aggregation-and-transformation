USE sakila;

-- Desafío 1.1: duración mínima y máxima
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- Desafío 1.2: duración promedio en horas y minutos, sin decimales
SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(MOD(AVG(length), 60)) AS minutes
FROM film;

-- Desafío 2.1: días entre el primer y el último alquiler registrado
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- Desafío 2.2: alquileres con el mes y el día de la semana, máximo 20 filas
SELECT
    rental.*,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Desafío 2.3 (bonus): indicar si el alquiler fue en fin de semana o día laborable
SELECT
    rental.*,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'fin de semana'
        ELSE 'día laborable'
    END AS DAY_TYPE
FROM rental;

-- Desafío 3: título y duración del alquiler; mostrar texto si es NULL
SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'No disponible') AS rental_duration
FROM film
ORDER BY title ASC;

-- Extra: nombre, apellido y los tres primeros caracteres del correo
SELECT
    first_name,
    last_name,
    SUBSTRING(email, 1, 3) AS email_start
FROM customer
ORDER BY last_name ASC;

-- Desafío 2, apartado 1.1: número total de películas
SELECT COUNT(*) AS total_films
FROM film;

-- Desafío 2, apartado 1.2: películas por clasificación
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- Desafío 2, apartado 1.3: clasificaciones ordenadas por cantidad de películas
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- Desafío 2, apartado 2.1: duración promedio por clasificación
SELECT rating, ROUND(AVG(length), 2) AS average_length
FROM film
GROUP BY rating
ORDER BY average_length DESC;

-- Desafío 2, apartado 2.2: clasificaciones con duración promedio superior a 2 horas
SELECT rating, ROUND(AVG(length), 2) AS average_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_length DESC;

-- Bonus: apellidos de actores que aparecen una sola vez
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(MOD(AVG(length), 60)) AS minutes
FROM film; 
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental; 
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
SELECT
    rental.*,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
SELECT
    rental.*,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'fin de semana'
        ELSE 'día laborable'
    END AS DAY_TYPE
FROM rental;
SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'No disponible') AS rental_duration
FROM film
ORDER BY title ASC;
SELECT
    first_name,
    last_name,
    SUBSTRING(email, 1, 3) AS email_start
FROM customer
ORDER BY last_name ASC;
SELECT COUNT(*) AS total_films
FROM film;
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;
SELECT
    rating,
    ROUND(AVG(length), 2) AS average_length
FROM film
GROUP BY rating
ORDER BY average_length DESC;
SELECT
    rating,
    ROUND(AVG(length), 2) AS average_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_length DESC;
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;