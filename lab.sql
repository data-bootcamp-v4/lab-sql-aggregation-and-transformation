USE sakila;

SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration 
FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS hours, 
    ROUND(AVG(length) % 60) AS minutes 
FROM film;

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operation_days 
FROM rental;


SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT 
    rental_id,
    rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;


SELECT 
    title,
    IFNULL(length, 'Not Available') AS rental_duration
FROM film
ORDER BY title;


SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT(SUBSTRING(email, 1, 3), '...') AS email_prefix
FROM customer
ORDER BY last_name;


SELECT 
    COUNT(*) AS total_films 
FROM film;


SELECT 
    rating, 
    COUNT(*) AS count 
FROM film 
GROUP BY rating;


SELECT 
    rating, 
    COUNT(*) AS count 
FROM film 
GROUP BY rating 
ORDER BY count DESC;


SELECT 
    rating, 
    ROUND(AVG(length), 2) AS average_duration 
FROM film 
GROUP BY rating 
ORDER BY average_duration DESC;


SELECT 
    rating, 
    ROUND(AVG(length), 2) AS average_duration 
FROM film 
GROUP BY rating 
HAVING average_duration > 120;


