USE sakila;

SELECT length
FROM sakila.film;

SELECT 
MAX(length) AS max_duration,
MIN(length) AS min_duration
FROM sakila.film; 

SELECT
FLOOR(AVG(length)/60) AS avg_hour,
MOD(AVG(length),60) AS avg_minute
FROM sakila.film;

SELECT *
FROM sakila.rental; 

SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) AS operating_days
FROM sakila.rental;

SELECT 
rental_date,
rental_id,
DATE_FORMAT(rental_date, '%m') AS month_of_rental,
DATE_FORMAT(rental_date,'%d') AS date_of_rental
FROM sakila.rental
LIMIT 20; 

SELECT rental_date
FROM sakila_rental; 

SELECT rental_date,
rental_id,
CASE 
WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
ELSE 'weekday'
END AS day_type
FROM sakila.rental;

SELECT *
FROM sakila.film;

SELECT title,rental_duration,
IFNULL(rental_duration,'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

SELECT *
FROM sakila.customer;

SELECT first_name, last_name,
CONCAT(first_name, ' ',last_name) AS full_name,
LEFT(email,3) AS email_prefix
FROM sakila.customer
ORDER BY last_name ASC;

SELECT *
FROM sakila.film;

SELECT 
COUNT(film_id) AS total_number_films
FROM sakila.film; 

SELECT rating,
COUNT(film_id) AS number_of_films
FROM sakila.film
GROUP BY rating;

SELECT rating,
COUNT(rating) AS number_of_each_rating
FROM sakila.film
GROUP BY rating
ORDER BY number_of_each_rating DESC;

SELECT *
FROM sakila.film;


SELECT rating,
ROUND(AVG(length),2) AS mean_duration
FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC;


SELECT rating,
ROUND(AVG(length),2) AS mean_duration
FROM sakila.film
GROUP BY rating;

SELECT rating,
ROUND(AVG(length),2) AS mean_duration
FROM sakila.film
GROUP BY rating
HAVING AVG(length)>120
ORDER BY mean_duration DESC;











