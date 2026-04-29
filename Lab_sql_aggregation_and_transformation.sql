USE sakila;

-- RETO 1

-- 1.1 Determinar la duración mínima y máxima de las películas
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Expresar la duración media de las películas en horas y minutos
SELECT
    FLOOR(AVG(length) / 60) AS average_hours,
    ROUND(AVG(length) % 60) AS average_minutes
FROM film;

-- 2.1 Calcular el número de días que la empresa ha estado operando
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Obtener información de los alquileres y añadir columnas de mes y día de la semana
SELECT
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: Añadir una columna DAY_TYPE con valores weekend/workday
SELECT
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3. Obtener títulos de películas y duración de alquiler, reemplazando NULL por 'Not Available'
SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. BONUS: Concatenar nombre y apellido, y mostrar los 3 primeros caracteres del email
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- RETO 2

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

-- 1.3 Número de películas por rating ordenado de mayor a menor
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Duración media de las películas para cada rating
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings cuya duración media es mayor a 2 horas
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- 3. BONUS: Apellidos que no se repiten en la tabla actor
SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;