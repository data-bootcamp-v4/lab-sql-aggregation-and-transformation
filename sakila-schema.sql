USE SAKILA 

-- Desafío 1
-- Debe utilizar las funciones integradas de SQL para obtener información relacionada con la duración de las películas. 

-- 1.1 Determine las duraciones más cortas y más largas de las películas y nombre los valores como max_duration y min_duration.
    SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film; 

-- 1.2. Expresa la duración media de una película en horas y minutos. No utilices decimales.
-- Sugerencia: Busque funciones de piso y redondas.
    SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes FROM film; 

-- 2 Necesita obtener información relacionada con las fechas de alquiler:
-- 2.1 Calcular el número de días que la empresa lleva operando.
    SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) FROM rental; 


-- 2.2 Recupere información de alquiler y agregue dos columnas adicionales para mostrar el mes y el día de la semana del alquiler. 
-- Devuelva 20 filas de resultados.
    SELECT DATE_FORMAT(rental_date, '%M') AS month, DATE_FORMAT(rental_date, '%W') AS weekday FROM rental LIMIT 20; 

-- 2.3 Bonus: Recupere información de alquiler y agregue una columna adicional llamada DAY_TYPE con valores 'fin de semana' o 'día laboral' , dependiendo del día de la semana.
-- Sugerencia: utilice una expresión condicional.

    SELECT CASE WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'fin de semana' ELSE 'día laboral' END AS day_type FROM rental; 

-- Debe asegurarse de que los clientes puedan acceder fácilmente a la información sobre la colección de películas.
-- Para lograrlo, recupere los títulos de las películas y la duración de su alquiler.
-- Si algún valor de duración de alquiler es NULL, reemplácelo con la cadena 'No disponible'.
-- Ordene los resultados del título de la película en orden ascendente.

-- Tenga en cuenta que incluso si actualmente no hay valores nulos en la columna de duración del alquiler,
-- la consulta debe escribirse para manejar dichos casos en el futuro.
-- Sugerencia: Busque la IFNULL()función.

    SELECT title, IFNULL(rental_duration, 'No disponible') AS rental_duration FROM film
    ORDER BY title; 

-- Bono: El equipo de marketing de la empresa de alquiler de películas ahora necesita crear una campaña de correo electrónico personalizada 
-- para los clientes. Para lograrlo, debe recuperar los nombres y apellidos concatenados de los clientes,junto con los primeros 3 caracteres de su 
-- dirección de correo electrónico, para poder dirigirse a ellos por su nombre y usar su dirección de correo electrónico para enviar recomendaciones 
-- personalizadas. Los resultados deben ordenarse por apellido en orden ascendente para facilitar el uso de los datos.

    SELECT CONCAT(first_name, ' ', last_name) AS full_name, SUBSTRING(email, 1, 3) AS email_prefix FROM customer
    ORDER BY last_name; 


-- Desafío 2

-- A continuación, debe analizar las películas de la colección para obtener más información. Con la film tabla, determine:
-- 1.1 El número total de películas que se han estrenado.

    SELECT COUNT(*) FROM film
    GROUP BY title; 

-- 1.2 El número de películas para cada clasificación .

    SELECT rating, COUNT(*) FROM film
    GROUP BY rating; 

-- 1.3 La cantidad de películas por clasificación, ordenando los resultados en orden descendente según la cantidad de películas.
-- Esto le ayudará a comprender mejor la popularidad de las diferentes clasificaciones de películas y a tomar decisiones de compra en consecuencia.

    SELECT rating, COUNT(*) FROM film
    GROUP BY rating
    ORDER BY COUNT(*) DESC; 

-- Utilizando la film tabla, determine:
-- 2.1 La duración media de las películas para cada clasificación y ordena los resultados en orden descendente de duración media.
-- Redondea las duraciones medias a dos decimales. Esto ayudará a identificar las duraciones de películas más populares para cada categoría.

    SELECT rating, ROUND(AVG(length), 2) AS average_duration FROM film
    GROUP BY rating
    ORDER BY average_duration DESC; 

-- 2.2 Identificar qué clasificaciones tienen una duración media de más de dos horas para ayudar a seleccionar películas para los clientes 
-- que prefieren películas más largas.

    SELECT rating, ROUND(AVG(length), 2) AS average_duration FROM film
    GROUP BY rating
    HAVING average_duration > 120; 

-- Bono: determina cuáles apellidos no se repiten en la tabla actor.
    SELECT last_name FROM actor
    GROUP BY last_name
    HAVING COUNT(*) = 1; 
