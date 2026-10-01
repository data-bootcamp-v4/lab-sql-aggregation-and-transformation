USE sakila;

-- calcular la pelicula mas larga y la mas corta
SELECT
MIN(length) AS min_duration, 
MAX(length) AS max_duration
FROM film;

-- ver el average en horas y minutos
SELECT
FLOOR(AVG(length) / 60) AS hours,
ROUND(AVG(length) % 60) AS minutes
FROM film;

-- 2.1 Días que lleva operando la empresa
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Alquileres con el mes y el día de la semana (20 filas)
SELECT
    *,
    MONTH(rental_date)     AS rental_month,
    DAYNAME(rental_date)   AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: columna DAY_TYPE (weekend / workday)
SELECT
    *,
    MONTH(rental_date)   AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- film titles and their rental duration
SELECT title,
       COALESCE(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Bonus
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- CHALLENGE 2
-- 1.1 Total de películas
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 Películas por clasificación (rating)
SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating;

-- 1.3 Lo mismo, de mayor a menor
SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

-- 2.1 Duración media por rating, de mayor a menor
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings con duración media superior a 2 horas
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

