-- 1.1 Determine las duraciones más cortas y más largas de las películas y nombre los valores como max_durationy min_duration

SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM film;

-- 1.2. Expresa la duración media de una película en horas y minutos

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.1 Calcular el número de días que la empresa lleva operando .
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Recupere información de alquiler y agregue dos columnas adicionales para mostrar el mes y el día de la semana del alquiler . Devuelva 20 filas de resultados.
SELECT 
    rental_id, 
    customer_id, 
    rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Recupere información de alquiler y agregue una columna adicional llamada DAY_TYPEcon valores 'fin de semana' o 'día laboral' , dependiendo del día de la semana.
SELECT 
    rental_id, 
    customer_id, 
    rental_date, 
    DAYNAME(rental_date) AS rental_weekday, 
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

--  4. El equipo de marketing de la empresa de alquiler de películas ahora necesita crear una campaña de correo electrónico personalizada para los clientes. Para lograrlo, debe recuperar los nombres y apellidos concatenados de los clientes , junto con los primeros 3 caracteres de su dirección de correo electrónico
SELECT 
    CONCAT(first_name, ' ', last_name) AS customer_name, 
    LEFT(email, 3) AS email_start
FROM customer
ORDER BY last_name ASC;

-- Parte 2 
-- 1.1 El número total de películas que se han estrenado.
SELECT 
    COUNT(*) AS total_films
FROM film;

-- 1.2 El número de películas para cada clasificación .
SELECT 
    rating, 
    COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- 1.3 La cantidad de películas por clasificación, ordenando los resultados en orden descendente según la cantidad de películas.
SELECT 
    rating, 
    COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;
-- 2.1 La duración media de las películas para cada clasificación y ordena los resultados en orden descendente de duración media.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 Identificar qué clasificaciones tienen una duración media de más de dos horas para ayudar a seleccionar películas para los clientes que prefieren películas más largas.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Bono: determina cuáles apellidos no se repiten en la tabla actor.
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;

