-- Active: 1721292127253@@127.0.0.1@3306@sakila
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
SELECT MAX(length) AS max_duration 
FROM film;
SELECT MIN(length) AS min_duration
FROM film;
SELECT ROUND(AVG(length))  AS avg_duration
FROM film;
--2. You need to gain insights related to rental dates:
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
SELECT *, DATE_FORMAT(rental_date, '%M') AS MONTH, DATE_FORMAT(rental_date, '%W') AS WEEKDAY
FROM rental
LIMIT 20;
SELECT *, CASE WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend' ELSE 'workday' END AS day_type
FROM rental;
-- 3.You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

--DESAFIO 2
--1. A continuación, debe analizar las películas de la colección para obtener más información. Con la filmtabla, determine:
SELECT COUNT(release_year)
FROM film;
SELECT COUNT(film_id),
    rating
FROM film
GROUP BY rating;
SELECT COUNT(film_id),
    rating
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) desc;
--2.Utilizando la filmtabla, determine:
SELECT ROUND(AVG(length),2),
    rating
FROM film
GROUP BY rating
ORDER BY ROUND(AVG(length),2) desc;
SELECT ROUND(AVG(length),2),
    rating
FROM film
GROUP BY rating
HAVING ROUND(AVG(length),2) > 120;
--BONUS
SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(last_name) = 1;
