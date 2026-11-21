USE sakila;

-- Challenge 1
-- 1.1 Duración mínima y máxima de las películas

select
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Duración media de las películas en horas y minutos

SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(MOD(AVG(length), 60)) AS minutes
FROM film;

-- 2.1 Número de días de funcionamiento de la empresa

select
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Información de alquileres con mes y día de la semana

select
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Clasificar los alquileres como weekend o workday

select
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

SELECT
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
WHERE DAYNAME(rental_date) IN ('Saturday', 'Sunday')
LIMIT 5;

-- 3. Título y duración de alquiler, gestionando valores NULL

select
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. Bonus: Información de clientes para campaña de email

select
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1 Número total de películas

select
    COUNT(*) AS total_films
FROM film;

-- 1.2 Número de películas por rating

SELECT
    rating,
    COUNT(*) AS total_films
FROM film
GROUP BY rating;

-- 1.3 Número de películas por rating, de mayor a menor

SELECT
    rating,
    COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

-- 2.1 Duración media de las películas por rating

SELECT
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 Ratings con una duración media superior a 2 horas

SELECT
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- 3. Bonus: Apellidos de actores que no se repiten

SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;