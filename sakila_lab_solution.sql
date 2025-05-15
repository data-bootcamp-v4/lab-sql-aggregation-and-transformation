-- Duraciones más cortas y más largas
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- Duración media de una película en horas y minutos (sin decimales)
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- Días operando la empresa (usando DATEDIFF)
SELECT DATEDIFF(
    (SELECT MAX(rental_date) FROM rental),
    (SELECT MIN(rental_date) FROM rental)
) AS operating_days;

-- Añadir mes y día de la semana a los alquileres (20 filas)
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- (Bonus) – Añadir columna DAY_TYPE como 'weekend' o 'weekday
SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'weekday'
    END AS day_type
FROM rental
LIMIT 20;

-- Duración de alquiler por título con IFNULL (en orden alfabético)
SELECT 
    title,
    IFNULL(rental_duration, 'Not available') AS rental_duration
FROM film
ORDER BY title ASC;

-- BONUS: marketing – nombre, apellido y primeros 3 caracteres del correo electrónico.
SELECT 
    first_name,
    last_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Número total de películas.
SELECT COUNT(*) AS total_films
FROM film;

-- Número de películas por clasificación (rating).
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- Número de películas por clasificación, en orden descendente.
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- Duración media por clasificación (orden descendente y redondeada a 2 decimales).
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- Clasificaciones con duración media > 120 minutos.
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;

-- BONUS – Apellidos no repetidos en la tabla actor.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

