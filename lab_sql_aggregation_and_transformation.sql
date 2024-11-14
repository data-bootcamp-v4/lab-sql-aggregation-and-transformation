# 1.1 Determine the shortest and longest movie durations
USE sakila;

SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM 
    film;

#1.2 Express average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM 
    film;

#2.1 Calculate days company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM 
    rental;
#2.2 Retrieve rental information with month and weekday
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    return_date,
    staff_id,
    last_update,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

#2.3 Add column DAY_TYPE with 'weekend' or 'workday'
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    last_update,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM 
    rental;

#3 Retrieve film titles and rental duration with NULL handling
SELECT 
    title AS film_title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;

#4 Retrieve concatenated customer name and email prefix
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM 
    customer
ORDER BY 
    last_name ASC;

#1.1 Determine total number of films
SELECT 
    COUNT(*) AS total_films
FROM 
    film;

#1.2 Determine number of films for each rating
SELECT 
    rating,
    COUNT(*) AS film_count
FROM 
    film
GROUP BY 
    rating;

#1.3 Sort films by rating count in descending order
SELECT 
    rating,
    COUNT(*) AS film_count
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    film_count DESC;

#2.1 Mean film duration per rating
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    mean_duration DESC;

#2.2 Ratings with mean duration over 2 hours
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
HAVING 
    AVG(length) > 120
ORDER BY 
    mean_duration DESC;

#3 Determine non-repeated last names in actor table
SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1;

