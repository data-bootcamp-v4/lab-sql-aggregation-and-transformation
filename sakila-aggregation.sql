-- =====================================================
-- LAB | SQL Data Aggregation and Transformation (sakila)
-- =====================================================
USE sakila;

-- ---------------- CHALLENGE 1 ----------------

-- 1.1 Duración máxima y mínima de las películas
SELECT MAX(length) AS max_duration,
       MIN(length) AS min_duration
FROM film;

-- 1.2 Duración media en horas y minutos (sin decimales)
SELECT FLOOR(AVG(length) / 60)  AS avg_hours,
       ROUND(AVG(length) % 60)  AS avg_minutes
FROM film;

-- 2.1 Días que lleva operando la empresa (última fecha de alquiler - primera)
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Información de alquileres con el mes y el día de la semana (20 filas)
SELECT *,
       MONTHNAME(rental_date) AS rental_month,
       DAYNAME(rental_date)   AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: columna DAY_TYPE con 'weekend' o 'workday'
SELECT *,
       CASE
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'   -- 1 = domingo, 7 = sábado
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental;

-- 3. Título y duración del alquiler; si es NULL -> 'Not Available'
SELECT title,
       IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. BONUS: nombre completo y 3 primeros caracteres del email, ordenado por apellido
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       SUBSTRING(email, 1, 3)             AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- ---------------- CHALLENGE 2 ----------------

-- 1.1 Número total de películas
SELECT COUNT(*) AS total_films FROM film;

-- 1.2 Número de películas por rating
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Lo mismo, ordenado de más a menos películas
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Duración media por rating, redondeada a 2 decimales, de mayor a menor
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings con duración media superior a 2 horas (120 min)
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- 3. BONUS: apellidos que no se repiten en la tabla actor
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
