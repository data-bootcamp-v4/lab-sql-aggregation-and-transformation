-- 1.1 Encuentra las duraciones más cortas y más largas de las películas
use sakila;
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;



-- 1.2 Duración media de una película en horas y minutos (sin decimales)

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;


-- 2.1 Calcular el número de días que la empresa lleva funcionando
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Recuperar información de alquiler y agregar columnas de mes y día de la semana
SELECT rental_id, rental_date,
       MONTHNAME(rental_date) AS rental_month,
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bono: Agregar DAY_TYPEcolumna para fin de semana o día laboral
SELECT rental_id, rental_date,
       CASE
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3. Recuperación de títulos de películas y duración del alquiler con manejo NULL
SELECT title, 
       IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. Bono: Concatenar nombre y apellido con subcadena de correo electrónico
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- 1.1 Número total de película

SELECT COUNT(*) AS total_films
FROM film;



-- 1.2 Número de películas para cada clasificación
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;


-- 1.3 Número de películas por clasificación, ordenado por número de películas
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;


-- 2.1 Duración media de la película para cada clasificación
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;


-- 2.2 Calificaciones con duración media superior a dos horas
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;


-- 3. Bono: Identificar apellidos no repetidos en la actortabla
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

