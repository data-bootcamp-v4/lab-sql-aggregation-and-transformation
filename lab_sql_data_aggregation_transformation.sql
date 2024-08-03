use sakila;

SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT 
    rental_id,
    rental_date,
    DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;

SELECT 
    rental_id,
    rental_date,
    DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT(SUBSTRING(email, 1, 3)) AS email_prefix
FROM customer
ORDER BY last_name ASC;

SELECT 
    COUNT(*) AS total_films
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
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;










