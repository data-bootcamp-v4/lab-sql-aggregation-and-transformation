USE sakila;
SHOW TABLES;

# 1.1 Determinar las duraciones más corta y más larga de las películas
SELECT 
    MAX(length) AS duracion_maxima,
    MIN(length) AS duracion_minima
FROM film;

/* Si quieres que salga el nombre de la pelicula
SELECT 
    f.title,
    f.length AS duracion
FROM film f
WHERE f.length = (SELECT MAX(length) FROM film)  -- Duración más larga
   OR f.length = (SELECT MIN(length) FROM film); -- Duración más corta
*/

# CHALLENGE 1

# 1.2 Exprimir la duración media de las películas en horas y minutos
SELECT 
    FLOOR(AVG(length) / 60) AS horas,
    MOD(ROUND(AVG(length)), 60) AS minutos
FROM film;

# 2.1 Calcular el número de días que la empresa ha estado operando
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS dias_operando
FROM rental;

# 2.2 Recuperar la información de alquiler y añadir el mes y el día de la semana
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    DATEDIFF(return_date, rental_date) AS dias_alquiler,
    MONTH(rental_date) AS mes,
    DAYOFWEEK(rental_date) AS dia_semana
FROM rental
LIMIT 20;

# 2.3 Bonificación: Añadir la columna TIPO_DÍA para identificar 'fin de semana' o 'día laborable'
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    DATEDIFF(return_date, rental_date) AS dias_alquiler,
    MONTH(rental_date) AS mes,
    DAYOFWEEK(rental_date) AS dia_semana,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'fin de semana'
        ELSE 'día laborable'
    END AS TIPO_DIA
FROM rental
LIMIT 20;

# 3. 
SELECT 
    f.title AS titulo_pelicula,
    IFNULL(f.rental_duration, 'No disponible') AS duracion_alquiler
FROM film f
ORDER BY f.title ASC;

# BONUS
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS nombre_completo,
    SUBSTRING(c.email, 1, 3) AS email_inicio
FROM customer c
ORDER BY c.last_name ASC;

# CHALLENGE 2

# 1.1 Número total de películas que se han estrenado
SELECT COUNT(film_id) AS total_peliculas
FROM film;

# 1.2 Número de películas de cada clasificación
SELECT rating, COUNT(film_id) AS peliculas_por_clasificacion
FROM film
GROUP BY rating;

# 1.3 Número de películas por clasificación, ordenadas por el número de películas (de mayor a menor)
SELECT rating, COUNT(film_id) AS peliculas_por_clasificacion
FROM film
GROUP BY rating
ORDER BY peliculas_por_clasificacion DESC;

# 2.1 Duración media de la película para cada clasificación, ordenada por duración media descendente
SELECT rating, ROUND(AVG(length), 2) AS duracion_media
FROM film
GROUP BY rating
ORDER BY duracion_media DESC;

# 2.2 Identificar clasificaciones con una duración media superior a dos horas
SELECT rating, ROUND(AVG(length), 2) AS duracion_media
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY duracion_media DESC;

# BONUS -> Determinar qué apellidos no se repiten en la tabla actor
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;