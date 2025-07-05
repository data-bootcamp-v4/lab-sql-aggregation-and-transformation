USE sakila;

SHOW TABLES;

SELECT MAX(length) AS max_duration,MIN(length) AS min_duration
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT rental_id,
MONTH(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT first_name,last_name,
LEFT(email, 3) AS email_prefix
FROM customer;

SELECT first_name,last_name,IFNULL(email, 'Not Available') AS email
FROM customer;

SELECT first_name,last_name,IFNULL(email, 'Not Available') AS email
FROM customer
ORDER BY last_name ASC;

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating,COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

SELECT rating,ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;




