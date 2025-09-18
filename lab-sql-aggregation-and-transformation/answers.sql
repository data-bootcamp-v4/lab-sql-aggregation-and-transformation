USE SAKILA;

#Challenge 1.1.1
SELECT MAX(length) 
AS max_duration
FROM film;

SELECT MIN(length) 
AS min_duration
FROM film;

#Challenge 1.1.2
SELECT ROUND(AVG(length))
FROM film;

#Challenge 1.2.1
SELECT DATEDIFF(
           (SELECT MAX(rental_date) FROM rental),
           (SELECT MIN(rental_date) FROM rental)
       ) AS operating_days;
       
#Challenge 1.2.2
SELECT *,
MONTH(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

#Challenge 1.2.3
SELECT *,
DAYNAME(rental_date) AS rental_weekday,
CASE
	WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
	ELSE 'workday'
    END AS day_type
FROM rental;

#Challenge 1.3
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

#Challenge 1.4
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

#Challenge 2.1.1
SELECT COUNT(*) 
FROM film;

#Challenge 2.1.2
SELECT COUNT(*), rating 
FROM film
GROUP BY rating;

#Challenge 2.1.3
SELECT COUNT(*) AS number_films_rating, rating 
FROM film
GROUP BY rating
ORDER BY number_films_rating ASC;

#Challenge 2.2.1
SELECT 
	ROUND(AVG(length),2) AS avg_lenght_films, 
	rating 
FROM film
GROUP BY rating
ORDER BY avg_lenght_films DESC;

#Challenge 2.2.2
SELECT 
	ROUND(AVG(length),2) AS avg_lenght_films, 
	rating 
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_lenght_films DESC;

#Challenge 2.3
SELECT DISTINCT 
    last_name AS unique_last_name
FROM actor;