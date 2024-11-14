USE sakila;

## 1.1 Determinar las duraciones de películas más cortas y más largas.
SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration 
FROM film;
## 1.2 Expresar la duración promedio de las películas en horas y minutos, sin usar decimales.
## Hint: Look for floor and round functions.
SELECT 
    FLOOR(AVG(length) / 60) AS hours, # Aquí se utiliza FLOOR para redondear hacia abajo y obtener la cantidad completa de horas y minutos. 
    FLOOR(AVG(length) % 60) AS minutes # El operador % (módulo) obtiene los minutos restantes después de las horas completas
FROM film;

## 2.1 Calcular el número de días que la empresa ha estado operando:
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

## 2.2 Recuperar información de alquiler y añadir dos columnas adicionales 
## para mostrar el mes y el día de la semana del alquiler.
## Devuelve 20 filas de resultados.

SELECT rental_id, rental_date, 
       MONTH(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_dayweek
FROM rental
LIMIT 20;

## 2.3 Bonus: Recuperar información de alquiler y añadir una columna adicional
## llamada DAY_TYPE con valores 'weekend' o 'workday' según el día de la semana

SELECT rental_id, rental_date, 
	CASE 
		WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' #  Los valores 1 y 7 corresponden a domingo y sábado
		ELSE 'workday' 
	END AS day_type
FROM rental;

## 3. Devuelve los títulos de las películas y su duración. 
## Si alguna duración es nula, reemplaza con la string 'Not Available'. 
## Ordena los resultados según el título de la película en orden ascendente.

SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

## 4. Devuelve concatenados el nombre y apellido de los clientes,
## junto con los tres primeros caracteres de su email. Los resultados deben ir ordenados por apellidos en orden ascendente. 

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix # SUBSTRING(Texto origen, Comienza en, Caracteres que coge)
FROM customer
ORDER BY last_name ASC;

######### CHALLENGE 2 ##########

## 1.1 Total de películas lanzadas

SELECT COUNT(*) AS total_films FROM film;

## 1.2 Número de películas por cada clasificación (rating)

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

## 1.3 Número de películas por cada clasificación, ordenado en orden descendente

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

## 2.1 Duración media de las películas por clasificación, ordenado en orden descendente de duración media

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

## 2.2 Clasificaciones con una duración media de más de dos horas (120 minutos)

SELECT rating
FROM film
GROUP BY rating
HAVING AVG(length) > 120;
## No podemos usar mean_duration porque 
## no se puede referenciar alias directamente en cláusulas 
## HAVING o WHERE en la misma consulta

## 2.3 Determinar qué apellidos no están repetidos en la columna actor,

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;