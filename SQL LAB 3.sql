USE sakila;
SHOW TABLES;

-- Max and min duration
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
 
 -- Average movie duration in hours and minutes
 
 SELECT AVG(length) AS avg_duration_minutes
FROM film;
SELECT FLOOR(  AVG(length) / 60  ) AS avg_hours
FROM film;
SELECT
    CONCAT(
        FLOOR(AVG(length) / 60),  
        ' hours and ',            
        ROUND(MOD(AVG(length), 60)),
        ' minutes'
    ) AS average_duration_hm
FROM film;

--  number of days that the company has been operating

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- show the month and weekday of the rental. Return 20 rows of results

SELECT 
    *,
    MONTH(rental_date) AS rental_month,   
    DAYNAME(rental_date) AS rental_weekday 
FROM rental
LIMIT 20;

--  'weekend' or 'workday
SELECT
    *,
    CASE
        -- La función DAYOFWEEK() devuelve 1 para Domingo y 7 para Sábado.
        WHEN DAYOFWEEK(rental_date) = 1 OR DAYOFWEEK(rental_date) = 7 THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE 
FROM rental
LIMIT 20;

-- null values 

SELECT title, rental_duration
FROM film
SELECT
    title, -- Mantenemos la columna del título
    IFNULL(rental_duration, 'Not Available') AS rental_duration_clean 
FROM film
ORDER BY title ASC;

-- BONUS
SELECT
    -- 1. Concatenamos nombre y apellido con un espacio
    CONCAT(first_name, ' ', last_name) AS full_name, 
    -- 2. Obtenemos los 3 primeros caracteres del email
    LEFT(email, 3) AS email_prefix
FROM customer
-- 3. Ordenamos los resultados por apellido (ascendente)
ORDER BY last_name ASC;

-- total number of films
SELECT COUNT(*) FROM film;

-- number of films for each rating
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;

-- number of films for each rating, sorting
SELECT 
    rating, 
    COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

--  mean film duration for each rating
SELECT
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- which ratings have a mean duration of over two hours
SELECT
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- determine which last names are not repeated in the table actor
SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;