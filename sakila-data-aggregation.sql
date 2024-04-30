USE sakila;

SHOW tables;

SELECT MIN(length) AS min_duration,
       MAX(length) AS max_duration
FROM film;

SELECT 
    CONCAT(FLOOR(AVG(length) / 60), ' hours ', ROUND(AVG(length) % 60, 2), ' minutes') AS avg_duration
FROM film;


SELECT
rental_date,
return_date,
DATEDIFF(return_date, rental_date) AS days_rented
FROM rental;

SELECT 
    MONTHNAME(rental_date) AS MONTH,
    DAYNAME(rental_date) AS WEEKDAY
FROM rental
LIMIT 20;

SELECT
    rental_date,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

SELECT 
    title,
    IFNULL(rental_duration, 2) AS 'Not Available'
FROM film
ORDER BY title ASC;


SELECT
	COUNT(DISTINCT film_id)
FROM film;

SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;



SELECT 
    rating,
    AVG(length) AS average_length,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
HAVING average_length > 120
ORDER BY number_of_films DESC;