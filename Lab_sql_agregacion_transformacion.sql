USE sakila;

-- Debe utilizar las funciones integradas de SQL para obtener información relacionada con la duración de las películas:
-- 1.1 Determine las duraciones más cortas y más largas de las películas y nombre los valores como max_durationy min_duration.
SELECT
MAX(length) AS max_duration,
MIN(length) AS min_duration
FROM film;

-- 1.2. Exprese la duración promedio de una película en horas y minutos . No use decimales.
-- Sugerencia: Busque funciones de piso y redondas.
SELECT
FLOOR(AVG(length) / 60) AS horas_promedio,
MOD(ROUND(AVG(length)), 60) AS minutos_promedio
FROM film;

-- Necesita obtener información relacionada con las fechas de alquiler:
-- 2.1 Calcula el número de días que lleva operando la empresa .
-- Sugerencia: para hacer esto, utilice la rental tabla y la DATEDIFF()función para restar la fecha más antigua en la rental_datecolumna de la fecha más reciente.
SELECT
DATEDIFF(MAX(rental_date), MIN(rental_date)) AS dias_operando
FROM rental;

-- 2.2 Recupere la información del alquiler y añada dos columnas adicionales para mostrar el mes y el día de la semana del alquiler . Devuelva 20 filas de resultados.
SELECT
rental_id,
rental_date,
inventory_id,
customer_id,
MONTH(rental_date) AS rent_month,
DAYNAME(rental_date) AS rent_day
FROM rental
LIMIT 20;

-- 2.3 Bonus: Recupere la información de alquiler y agregue una columna adicional llamada DAY_TYPEcon valores 'fin de semana' o 'día laboral' , según el día de la semana.
-- Sugerencia: utilice una expresión condicional.
SELECT
rental_id,
rental_date,
DAYNAME(rental_date) AS dia_semana,
CASE
	WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
	ELSE 'workday'
    END AS DAY_TYPE
FROM
    rental
LIMIT 20; 

-- Debe asegurarse de que los clientes puedan acceder fácilmente a la información sobre la colección de películas. Para ello, recupere los títulos de las películas y su duración de alquiler . Si algún valor de duración de alquiler es nulo, reemplácelo con la cadena "No disponible" . Ordene los resultados por título de película en orden ascendente.
-- Tenga en cuenta que incluso si actualmente no hay valores nulos en la columna de duración del alquiler, la consulta debe escribirse para manejar dichos casos en el futuro.
-- Sugerencia: Busque la IFNULL()función.

SELECT
title AS movie_name,
IFNULL(rental_duration, 'Not available') AS rent_time
FROM film
ORDER BY title ASC;

--  El equipo de marketing de la empresa de alquiler de películas necesita crear una campaña de correo electrónico personalizada
-- para sus clientes. Para ello, necesita recuperar los nombres y apellidos de los clientes , junto con los tres primeros 
-- caracteres de su dirección de correo electrónico, para poder dirigirse a ellos por su nombre y usar su dirección para 
-- enviarles recomendaciones personalizadas. Los resultados deben ordenarse por apellido en orden ascendente para facilitar el 
-- uso de los datos.

SELECT
first_name,  
last_name,  
LEFT(email, 3) AS email_pre
FROM customer
ORDER BY last_name ASC;

-- A continuación, debes analizar las películas de la colección para obtener más información. Con la filmtabla, determina:
-- 1.1 El número total de películas que se han estrenado.
SELECT 
COUNT(film_id) AS total_films_released
FROM film;

-- 1.2 El número de películas para cada clasificación .
SELECT
rating,
COUNT(film_id) AS movie_number
FROM film
GROUP BY
rating;

-- 1.3 El número de películas por clasificación, ordenando los resultados en orden descendente según el número de películas.
-- Esto le ayudará a comprender mejor la popularidad de las diferentes clasificaciones de películas y a adaptar sus decisiones
-- de compra en consecuencia.

SELECT
rating,
COUNT(film_id) AS movie_number
FROM film
GROUP BY
rating
ORDER BY movie_number DESC;

-- Utilizando la film tabla, determine:
-- 2.1 La duración media de las películas para cada clasificación y ordena los resultados en orden descendente según la duración 
-- media. Redondea las duraciones medias a dos decimales. Esto ayudará a identificar las duraciones más populares de 
-- las películas en cada categoría.
SELECT
rating,
ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY 
rating
ORDER BY avg_length DESC;

-- 2.2 Identificar qué clasificaciones tienen una duración media de más de dos horas para ayudar a seleccionar películas para 
-- los clientes que prefieren películas más largas.
SELECT
rating,
ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY 
rating
HAVING avg_length > 120
ORDER BY avg_length DESC;

-- Bono: determina cuáles apellidos no se repiten en la tabla actor
SELECT
last_name AS unique_last_name
FROM actor
GROUP BY
last_name
HAVING COUNT(last_name) = 1
ORDER BY last_name ASC;


