USE sakila;

#Challenge1
1.1 
#Extraemos de la tabla las peliculas con mayor y menor duración
SELECT 
  MIN(length) AS min_duration,
  MAX(length) AS max_duration
FROM film;

1.2
#Aquí se hace una media de la duración de las películas, realizando una conversión del tiempo en horas y minutos
SELECT 
  FLOOR(AVG(length) / 60) AS avg_hours,
  FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

2.1
SELECT 
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

2.2
SELECT 
  rental_id,
  rental_date,
  MONTH(rental_date) AS rental_month,
  DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

2.3
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

3
SELECT 
  title,
  IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

4
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


#Challenge2
1.1
#Se hace un conteo del total de películas
SELECT 
COUNT(*) AS total_films
FROM film;

1.2
#Se divide el total de las películas en función del rating o calificación
SELECT 
  rating,
  COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

1.3
#Sobre el ejercicio anterior, se hace un orden descendente, para determinar los ratings con mayor cantidad de películas
SELECT 
  rating,
  COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

2.1
#Se realiza una media de la duración de cada rating, y luego se los ordena
SELECT 
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

2.2
#Conociendo el orden y la media de la duración, mediante la funcion HAVING queremos que de esa tabla nos filtre aquellos ratings cuya media supere los 120 minutos
SELECT 
  rating,
  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

3
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
