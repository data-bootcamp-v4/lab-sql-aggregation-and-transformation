-- =========================
-- CHALLENGE 1
-- =========================

-- 1.1 Duración mínima y máxima
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Duración media en horas y minutos (sin decimales)
SELECT 
    CONCAT(FLOOR(AVG(length) / 60), ' h ', FLOOR(AVG(length) % 60), ' min') AS average_duration
FROM film;

-- 2.1 Número de días operando
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Información de alquiler con mes y día de la semana
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: columna DAY_TYPE
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3 Sustituir NULL en rental_duration
SELECT 
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- BONUS: nombre completo + 3 primeras letras del email
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- =========================
-- CHALLENGE 2
-- =========================

-- 1.1 Número total de películas
SELECT 
    COUNT(*) AS total_films
FROM film;

-- 1.2 Número de películas por rating
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Número de películas por rating (orden descendente)
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Duración media por rating (orden descendente)
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings con duración media superior a 120 minutos
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;


-- =========================
-- BONUS FINAL
-- =========================

-- Apellidos no repetidos en actor
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;