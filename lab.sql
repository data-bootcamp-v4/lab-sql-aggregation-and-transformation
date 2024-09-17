-- Determine las duraciones más cortas y más largas de las películas y nombre los valores como max_durationy min_duration.
SELECT MAX(length) as max_duration, MIN(length) as min_duration 
FROM sakila.film;

-- Expresa la duración media de una película en horas y minutos . No utilices decimales.
-- Sugerencia: Busque funciones de floor y round.
SELECT 
	FLOOR(AVG(length) / 60) as hours,
    ROUND(AVG(length) % 60) as mins
FROM sakila.film;

--  Calcular el número de días que la empresa lleva operando .
-- Sugerencia: para hacer esto, utilice la rental tabla y la DATEDIFF()función para restar la fecha más antigua en la rental_datecolumna de la fecha más reciente.
SELECT 
	DATEDIFF(MAX(rental_date), MIN(rental_date)) as dias_operando
FROM sakila.rental;

-- Recupere información de alquiler y agregue dos columnas adicionales para mostrar el mes y el día de la semana del alquiler . Devuelva 20 filas de resultados.
SELECT 
	rental_id, 
    rental_date, 
    MONTH(rental_date) as month_rental,
    DAYNAME(rental_date) as weekday_rental
FROM sakila.rental
LIMIT 20;

-- recupere los títulos de las películas y la duración de su alquiler . Si algún valor de duración de alquiler es NULL,
-- reemplácelo con la cadena 'No disponible' . Ordene los resultados del título de la película en orden ascendente.
SELECT 
	title, 
    IFNULL(rental_duration, "Not Available")
FROM sakila.film
ORDER BY title ASC;
 
 -- El número total de películas que se han estrenado.
 SELECT COUNT(release_year) FROM sakila.film;
-- El número de películas para cada clasificación.
SELECT 
	rating,
    COUNT(*) as number_of_films
FROM sakila.film
GROUP BY rating;
--  La cantidad de películas por clasificación, ordenando los resultados en orden descendente
SELECT
	rating,
    COUNT(*) as number_of_films
FROM sakila.film
GROUP BY rating
ORDER BY number_of_films DESC;

-- La duración media de las películas para cada clasificación y ordena los resultados en orden descendente de duración media. Redondea las duraciones medias a dos decimales.
SELECT 
	rating,
	ROUND(AVG(length), 2) as media_duracion
FROM sakila.film
GROUP BY rating
ORDER BY media_duracion DESC;

-- Identificar qué clasificaciones tienen una duración media de más de dos horas para ayudar a seleccionar películas para los clientes que prefieren películas más largas.
SELECT 
	rating,
    ROUND(AVG(length), 2) as duracion_media
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120;