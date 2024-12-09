-- Ensure you're working with the Sakila database
USE sakila;

-- 1.1 Shortest and longest movie durations
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes
SELECT 
    CONCAT(FLOOR(AVG(length) / 60), ' hours ', ROUND(AVG(length) % 60), ' minutes') AS avg_duration
FROM film;

-- 2.1 Number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Rental information with month and weekday
SELECT 
    rental_id,
    rental_date,
    customer_id,
    film_id,
    MONTH(rental_date) AS rental_month,
    DAYOFWEEK(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Rental information with weekend/workday categorization
SELECT 
    rental_id,
    rental_date,
    customer_id,
    film_id,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- 3. Film titles and rental duration (handling NULL)
SELECT 
    f.title, 
    IFNULL(r.rental_duration, 'Not Available') AS rental_duration
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title ASC;

-- 4. Customer email campaign (first and last names with email prefix)
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUBSTRING(c.email, 1, 3) AS email_prefix
FROM customer c
ORDER BY c.last_name ASC;
