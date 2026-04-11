CREATE DATABASE sakila;
USE sakila;
SHOW TABLES;

SHOW TABLES IN sakila;
SELECT * FROM sakila.actor;
SELECT * FROM sakila.film;
SELECT * FROM sakila.customer;
SELECT title FROM sakila.film;
SELECT title FROM film;
SELECT first_name FROM staff;
SELECT COUNT(*) AS total_stores FROM store;
SELECT COUNT(*) AS total_staff FROM staff;
SELECT COUNT(*) AS available_films FROM inventory;
SELECT COUNT(*) AS rented_films FROM rental;
SELECT COUNT(DISTINCT last_name) AS unique_last_names FROM actor;
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 10;
SELECT *
FROM actor
WHERE first_name = 'SCARLETT';
SELECT *
FROM film
WHERE title LIKE '%ARMAGEDDON%'
AND length > 100;
SELECT COUNT(*) AS behind_the_scenes_films
FROM film
WHERE special_features LIKE '%Behind the Scenes%';
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    FLOOR(AVG(length) % 60) AS minutes
FROM film;
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS month,
    DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;
SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS weekday,
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;
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
SELECT COUNT(*) AS total_films
FROM film;
SELECT 
    rating,
    COUNT(*) AS total
FROM film
GROUP BY rating;
SELECT 
    rating,
    COUNT(*) AS total
FROM film
GROUP BY rating
ORDER BY total DESC;
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
