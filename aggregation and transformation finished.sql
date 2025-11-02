#1
use sakila;
SELECT MAX(length) from film;
SELECT MIN(length) from film;
-- floor convierte minutos en horas
SELECT FLOOR(AVG(length)/60) AS hours,
-- mod convierte el sobrante en minutos 
ROUND(MOD(AVG(length),60)) AS minutes
 FROM film;
 
 #2
 -- DATEDIFF() Calcula la diferencia entre dos fechas y las devuelve en una unidad SELECT DATEDIFF( '2017/08/25', '2011/08/25') AS DateDiff
 -- 2.1 Calculate the number of days that the company has been operating
 SELECT * from rental;
 SELECT DATEDIFF( MAX(last_update),MIN(rental_date)) FROM rental;
 -- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
 SELECT MONTHNAME(rental_date) AS month_name,
 DAYNAME(rental_date) AS week_day,
 -- case introduces conditional decision its like if then else
 CASE 
	WHEN DAYOFWEEK(rental_date) IN (1,7) then 'weekend'
    ELSE 'workday'
    END AS day_type
from rental
limit 20;
--  2.3

 SELECT rental_id, rental_date, customer_id, CASE 
 WHEN DAYOFWEEK(rental_date) IN (1,7) then 'WEEKEND'
 ELSE 'workday'
 END AS DAY_TYPE
 from rental;
 
 # 3
 SELECT title AS film_title,
 IFNULL(rental_duration, 'Not Available') AS rental_duration_till_return
 FROM film
 ORDER BY title ASC;
 
 # Challenge 2 
 -- 1.1
 SELECT COUNT(*) AS total_films
 FROM film;
 
 -- 1.2
 SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;
-- 1.3
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
-- 2.2 
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;