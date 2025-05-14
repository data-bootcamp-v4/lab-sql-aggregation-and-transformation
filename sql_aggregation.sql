-- DESAFÍO 1 
-- 1.1 
USE sakila; 

SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

--  1.2.
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length)) % 60 AS avg_minutes
FROM film;
-- FLOOR() cuando no quieres decimales y necesitas trabajar 
-- con la parte entera (por ejemplo, al calcular horas a partir de minutos)


-- 2. 
-- 2.1 
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS dias_operando
FROM rental;
-- DATEDIFF(fecha1, fecha2) → devuelve la cantidad de días entre dos fechas.

-- 2.2 
SELECT 
    rental_id,
    rental_date,
    customer_id,
    staff_id,
    inventory_id,
    MONTHNAME(rental_date) AS mes,
    DAYNAME(rental_date) AS dia_semana
FROM rental
LIMIT 20;
-- DAYNAME(rental_date) → Devuelve el nombre del día (por ejemplo: 'Monday').
-- MONTHNAME(rental_date) → Devuelve el nombre del mes (por ejemplo: 'March')

-- 2.3
SELECT 
    rental_id,
    rental_date,
    customer_id,
    staff_id,
    inventory_id,
    MONTHNAME(rental_date) AS mes,
    DAYNAME(rental_date) AS dia_semana,
    CASE 
		WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'fin de semana'
		ELSE 'día laboral'
    END AS day_type
FROM rental
LIMIT 20;

-- 3. Debe asegurarse de que los clientes puedan acceder fácilmente a la información sobre la colección de películas. +
-- Para ello, recupere los títulos de las películas y su duración de alquiler . Si algún valor de duración de alquiler es nulo, reemplácelo con la cadena "No disponible" . +
-- Ordene los resultados por título de película en orden ascendente.
-- Tenga en cuenta que incluso si actualmente no hay valores nulos en la columna de duración del alquiler, la consulta debe escribirse para manejar dichos casos en el futuro.
-- Sugerencia: busque la IFNULL()función.

SELECT
title, 
IFNULL(length,"No disponible") AS duration
FROM film 
ORDER BY title;
 -- ISNULL() sintaxi: IFNULL(columna, valor_por_defecto)

-- 4. BONUS
--  El equipo de marketing de la empresa de alquiler de películas necesita crear una campaña de correo electrónico personalizada para sus clientes. 
-- Para ello, necesita recuperar los nombres y apellidos de los clientes , junto con los tres primeros caracteres de su dirección de correo electrónico, para poder dirigirse a ellos por su nombre y usar su dirección para enviarles recomendaciones personalizadas. Los resultados deben ordenarse por apellido en orden ascendente para facilitar el uso de los datos.
SELECT 
    first_name,
    last_name,
    SUBSTRING(email, 1, 3) AS email_ok
FROM customer
ORDER BY last_name;
-- SUBSTRING () sirve para extraer una parte de un texto.
-- Indica la posición de inicio específica + longitud
-- Sintaxi: SUBSTRING(cadena, posición_inicial, longitud) --> cadena es la palabra text a hacer pues ese corte

SELECT
CONCAT(first_name, ' ', last_name) AS full_name,
LEFT(email, 3) AS email_prefix
FROM 
customer
ORDER BY last_name ASC;
-- revisar este código con el left email 

-- DESAFÍO 2 
-- 1.1 
SELECT
COUNT(title) AS total_peliculas
FROM film; 

-- 1.2
SELECT
rating,COUNT(title) AS cantidad_peliculas
FROM film 
GROUP BY rating;

-- 1.3
SELECT
rating,COUNT(title) AS cantidad_peliculas
FROM film 
GROUP BY rating
ORDER BY cantidad_peliculas DESC;

-- 2.1 
SELECT 
rating, ROUND(AVG(length),2) AS duracion_media
FROM film 
GROUP BY rating
ORDER BY duracion_media DESC;

-- 2.2
SELECT 
rating, ROUND(AVG(length),2) AS duracion_media
FROM film 
GROUP BY rating
HAVING AVG(length) > 120;

-- 3 BONUS
SELECT last_name 
FROM actor 
GROUP BY last_name 
HAVING COUNT(*) = 1;



