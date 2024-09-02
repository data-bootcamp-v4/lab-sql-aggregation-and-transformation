-- challenge 1
USE Sakila;
SHOW TABLES;
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
-- 1.2 Express the average movie duration in hours and minutes. Don't use decimals
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;
-- 2
-- 2.1 Calculate the number of days that the company has been operating:
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results:
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday':
SELECT 
    rental_id,
    rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;
-- 3
-- Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with 'Not Available':
SELECT 
    f.title AS film_title,
    IFNULL(CAST(f.rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM 
    film f
ORDER BY 
    f.title;
-- Bonus 
-- Retrieve concatenated first and last names of customers, along with the first 3 characters of their email address
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name;

-- challenge 2
-- 1.1 Total Number of Films Released
SELECT 
    COUNT(*) AS total_films
FROM 
    film;
-- 1.2 Number of Films for Each Rating
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating;
-- 1.3 Number of Films for Each Rating (Sorted in Descending Order)
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    number_of_films DESC;
    
-- 2.1 Mean Film Duration for Each Rating (Rounded to Two Decimal Places)
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    mean_duration DESC;
-- 2.2 Ratings with Mean Duration Over Two Hours
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
HAVING 
    mean_duration > 120; -- Two hours = 120 minutes;
    
-- Bonus: Find Last Names Not Repeated in the Actor Table
SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1;