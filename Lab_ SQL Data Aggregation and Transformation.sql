-- USE SAKILA DATABASE
USE sakila;

-- CHALLENGE 1: Data Transformation and Formatting

-- 1.1 Determine the shortest and longest movie durations
-- Feedback: Added explicit aliases as requested
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration 
FROM film;

-- 1.2 Average movie duration in hours and minutes
-- Feedback: Confirmed as "Excellent job" using FLOOR and MOD
SELECT 
    FLOOR(AVG(length) / 60) AS hours, 
    ROUND(AVG(length) % 60) AS minutes 
FROM film;

-- 2.1 Calculate the number of days the company has been operating
-- Feedback: Use DATEDIFF on MAX and MIN rental_date
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days 
FROM rental;

-- 2.2 Retrieve rental information with month and weekday (20 rows)
-- Feedback: Using MONTHNAME and DAYNAME is preferred for readability
SELECT *, 
       MONTHNAME(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday 
FROM rental 
LIMIT 20;

-- 2.3 Add 'DAY_TYPE' column (weekend or workday)
-- Feedback: Corrected syntax for CASE WHEN with DAYNAME
SELECT *,
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental;

-- 3. Retrieve film titles and rental duration (Handle NULLs)
-- Feedback: Used IFNULL to replace empty values with 'Not Available'
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. Personalize customer communications
-- Feedback: Corrected CONCAT syntax and used LEFT for masking
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT(LEFT(email, 3), '...') AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- CHALLENGE 2: Grouping and Filtering

-- 1.1 Total number of films
SELECT COUNT(*) AS total_films FROM film;

-- 1.2 & 1.3 Number of films per rating (Sorted)
SELECT rating, COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating 
ORDER BY number_of_films DESC;

-- 2.1 Mean duration per rating
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with mean duration > 120 minutes
-- Feedback: Critical use of HAVING for filtered aggregates
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;