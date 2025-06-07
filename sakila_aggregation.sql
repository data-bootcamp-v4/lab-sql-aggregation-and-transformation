USE sakila;
#1.1 Shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
#1.2 Average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;
#2.1 Días totales de operación (desde la primera hasta la última fecha de alquiler)
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
#2.2 Alquileres con mes y día de la semana
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
# Agrega columna DAY_TYPE (workday o weekend)
SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;
#3. Títulos de películas y duración (reemplazar NULL por "Not Available")
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
#4. (Bonus) Nombres de cliente + primeras letras del correo
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
#1. Películas por rating
SELECT COUNT(*) AS total_films
FROM film;
#1.2 Número de películas por rating
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;
#1.3 Igual que anterior pero ordenado descendente
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;
#2. Duración promedio por rating
#2.1 Promedio redondeado a 2 decimales
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;
#2.2 Ratings con duración promedio > 120 min
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;

