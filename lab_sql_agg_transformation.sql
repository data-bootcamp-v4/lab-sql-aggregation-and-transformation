USE sakila;
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;

SELECT
    MAX(rental_date),
    MIN(rental_date)
 FROM rental;   
 
 SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

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
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') 
        THEN 'weekend'
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
    LEFT(email, 3) AS short_email
FROM customer
ORDER BY last_name ASC;

SELECT COUNT(*) AS total_films
FROM film;

SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating;

SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
