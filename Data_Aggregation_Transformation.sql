-- Desafío 1
-- Debe utilizar las funciones integradas de SQL para obtener información relacionada con la duración de las películas:

USE sakila;

-- 1.1 Determine las duraciones más cortas y más largas de las películas y nombre los valores como max_durationy min_duration.

SELECT length
FROM film;

SELECT MIN(length) as min_duration , MAX(length) as max_duration, title
FROM film; 

SELECT 
    title, 
    length AS max_duration
FROM 
    film
WHERE 
    length = (SELECT MAX(length) FROM film);
    
   
SELECT title, length AS min_duration
FROM film
WHERE length = (SELECT MIN(length) FROM film);

-- 1.2. Expresa la duración media de una película en horas y minutos . No utilices decimales.
-- Sugerencia: Busque funciones de piso y redondas.
-- Necesita obtener información relacionada con las fechas de alquiler:
SELECT FLOOR(AVG(length) / 60) AS avg_hours, ROUND(AVG(length) % 60) AS avg_minutes 
FROM film;

SELECT TIME(ROUND(AVG(length))) 
FROM film;

-- 2.1 Calcular el número de días que la empresa lleva operando .
-- Sugerencia: para hacer esto, utilice la rentaltabla y la DATEDIFF()función para restar la fecha más antigua en la rental_datecolumna de la fecha más reciente.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM rental;

-- 2.2 Recupere información de alquiler y agregue dos columnas adicionales para mostrar el mes y el día de la semana del alquiler . Devuelva 20 filas de resultados.
SELECT rental_date, MONTH(rental_date), WEEKDAY(rental_date)
FROM rental
LIMIT 20;

-- 2.3 Bonus: Recupere información de alquiler y agregue una columna adicional llamada DAY_TYPE con valores 'fin de semana' o 'día laboral' , dependiendo del día de la semana.
-- Sugerencia: utilice una expresión condicional.
SELECT *
FROM rental;

SELECT rental_date, 
CASE 
WHEN DAYOFWEEK(rental_date) IN (6,7) THEN 'weekend'
ELSE 'workday'
END AS day_type
FROM rental;

-- Debe asegurarse de que los clientes puedan acceder fácilmente a la información sobre la colección de películas. 
-- Para lograrlo, recupere los títulos de las películas y la duración de su alquiler . 
-- Si algún valor de duración de alquiler es NULL, reemplácelo con la cadena 'No disponible' . 
-- Ordene los resultados del título de la película en orden ascendente.
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration_status
FROM 
    film
ORDER BY 
    title;
-- Tenga en cuenta que incluso si actualmente no hay valores nulos en la columna de duración del alquiler, la consulta debe escribirse para manejar dichos casos en el futuro.
-- Bono: El equipo de marketing de la empresa de alquiler de películas ahora necesita crear una campaña de correo electrónico personalizada para los clientes. 
-- Para lograrlo, debe recuperar los nombres y apellidos concatenados de los clientes ,
--  junto con los primeros 3 caracteres de su dirección de correo electrónico, para poder dirigirse a ellos por su nombre y usar su dirección de correo electrónico para enviar recomendaciones personalizadas. 
-- Los resultados deben ordenarse por apellido en orden ascendente para facilitar el uso de los datos.
SELECT 
CONCAT (first_name,' ',last_name),
LEFT(email,3)
FROM customer
ORDER BY last_name;

-- Desafío 2
-- A continuación, debe analizar las películas de la colección para obtener más información. Con la filmtabla, determine:
-- 1.1 El número total de películas que se han estrenado.
SELECT COUNT(film_id)
FROM film;

-- 1.2 El número de películas para cada clasificación .
SELECT rating, COUNT(film_id) AS number_films
FROM film
GROUP BY rating;

-- 1.3 La cantidad de películas por clasificación, ordenando los resultados en orden descendente según la cantidad de películas. 
-- Esto le ayudará a comprender mejor la popularidad de las diferentes clasificaciones de películas y a tomar decisiones de compra en consecuencia.

SELECT COUNT(film_id), rating
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

-- Utilizando la filmtabla, determine:

-- 2.1 La duración media de las películas para cada clasificación y ordena los resultados en orden descendente de duración media. 
-- Redondea las duraciones medias a dos decimales. Esto ayudará a identificar las duraciones de películas más populares para cada categoría.

SELECT ROUND(AVG(length),2), rating
FROM film
GROUP BY rating
ORDER BY ROUND(AVG(length)) DESC;

-- 2.2 Identificar qué clasificaciones tienen una duración media de más de dos horas para ayudar a seleccionar películas para los clientes que prefieren películas más largas.

SELECT ROUND(AVG(length),2) AS duration_film, rating
FROM film
GROUP BY rating
HAVING duration_film > 120 
ORDER BY ROUND(AVG(length)) DESC;

-- Bono: determina cuáles apellidos no se repiten en la tabla actor.

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;
