USE SAKILA;
-- CHALLENGE 1
-- 1.1.
SELECT MAX(length) from sakila.film as max_duration;
SELECT MIN(length) from sakila.film as min_duration;
-- 1.2.
SELECT FLOOR(AVG(length)/60) AS hours, ROUND(AVG(length)%60) AS minutes from sakila.film;
-- 2.1.
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) AS days_operational FROM sakila.rental;
-- 2.2.
SELECT *, DATE_FORMAT(CONVERT(rental_date,DATE), '%M') AS month, DAYOFWEEK(CONVERT(rental_date,DATE)) AS dayofweek,
CASE
	WHEN DAYOFWEEK(CONVERT(rental_date,DATE)) = '2' THEN 'monday'
    WHEN DAYOFWEEK(CONVERT(rental_date,DATE)) = '3' THEN 'tuesday'
    WHEN DAYOFWEEK(CONVERT(rental_date,DATE)) = '4' THEN 'wednesday'
    WHEN DAYOFWEEK(CONVERT(rental_date,DATE)) = '5' THEN 'thrusday'
    WHEN DAYOFWEEK(CONVERT(rental_date,DATE)) = '6' THEN 'friday'
    WHEN DAYOFWEEK(CONVERT(rental_date,DATE)) = '7' THEN 'saturday'
    WHEN DAYOFWEEK(CONVERT(rental_date,DATE)) = '1' THEN 'sunday'
    ELSE ''
END AS weekday
FROM sakila.rental
LIMIT 20;
-- 2.3. 
SELECT *, DAYOFWEEK(CONVERT(rental_date,DATE)) AS weekday, 
CASE 
    WHEN DAYOFWEEK(CONVERT(rental_date,DATE)) IN (6,7) THEN 'weekend'
    ELSE 'workday'
END AS 'DAY_TYPE'
FROM sakila.rental
LIMIT 20;
-- 3.
SELECT title, IFNULL(rental_duration, 'Not available') AS rental_duration_nonull
FROM sakila.film 
ORDER BY title ASC; 
-- 4. 
SELECT email, first_name, last_name, CONCAT(first_name,last_name)AS first_last_names, LEFT(email,3) AS 3_car_email
FROM sakila.customer 
ORDER BY last_name ASC;

-- CHALLENGE 2
-- 1. 
-- 1.1.
SELECT COUNT(film_id) AS total_number_films
FROM sakila.film;
-- 1.2.
SELECT rating, COUNT(film_id) AS number_films_per_rating
FROM sakila.film
GROUP BY rating;
-- 1.3.
SELECT rating, COUNT(film_id) AS number_films_per_rating
FROM sakila.film
GROUP BY rating
ORDER BY number_films_per_rating DESC;
-- 2. 
-- 2.1.
SELECT ROUND(AVG(length),2) as mean_film_duration, rating
FROM sakila.film
GROUP BY rating
ORDER BY mean_film_duration DESC;
-- 2.2. 
SELECT ROUND(AVG(length),2) as mean_film_duration, rating
FROM sakila.film
GROUP BY rating
HAVING mean_film_duration> 120
ORDER BY mean_film_duration DESC;
-- 3.
SELECT DISTINCT(last_name)
FROM sakila.actor;


