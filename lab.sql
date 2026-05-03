CREATE DATABASE sakila;
USE sakila;

SHOW TABLES;

 #max_duration y min_duration
 -- CHALLENGE 1.1
-- MAX Y MIN DURACIÓN
 
 SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

SELECT AVG(length) AS avg_minutes
FROM film;

SELECT FLOOR(AVG(length) / 60) AS hours
FROM film;

SELECT MOD(AVG(length), 60) AS minutes
FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(MOD(AVG(length), 60), 0) AS minutes
FROM film;

SELECT 
    CONCAT(
        FLOOR(AVG(length) / 60),
        ' hr ',
        ROUND(MOD(AVG(length), 60), 0),
        ' min'
    ) AS avg_duration
FROM film;

-- =========================
-- CHALLENGE 1.2 - 2.1
-- =========================
SELECT 
    MIN(rental_date) AS first_rental,
    MAX(rental_date) AS last_rental
FROM rental;

SELECT 
    DATEDIFF(
        MAX(rental_date),
        MIN(rental_date)
    ) AS days_operating
FROM rental;

SELECT *
FROM rental
LIMIT 20;

SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
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

SELECT *
FROM customer
LIMIT 5;

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name
FROM customer;

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_preview
FROM customer;

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_preview
FROM customer
ORDER BY last_name ASC;

-- =========================
-- CHALLENGE 2
-- FILMS ANALYSIS
-- =========================
-- 2.1 Total films
SELECT 
    COUNT(*) AS total_films
FROM film;

-- 2.2 Films by rating
SELECT 
    rating,
    COUNT(*) AS total_films
FROM film
GROUP BY rating;


SELECT 
    rating,
    COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

SELECT 
    rating,
    AVG(length) AS avg_length
FROM film
GROUP BY rating;

SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating;

-- 2.3 Avg duration
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120;


-- =========================
-- BONUS
-- =========================

-- Actor last names not repeated
SELECT 
    last_name,
    COUNT(*) AS total
FROM actor
GROUP BY last_name;

SELECT 
    last_name,
    COUNT(*) AS total
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
