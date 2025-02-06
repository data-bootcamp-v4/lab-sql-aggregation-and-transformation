-- Use the Sakila database
USE sakila;

-- Challenge 1: Movie Duration Insights
-- 1.1 Determine the shortest and longest movie durations
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;

-- 1.2 Express the average movie duration in hours and minutes (no decimals)
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60, 0) AS avg_minutes 
FROM film;

-- Challenge 2: Rental Date Insights
-- 2.1 Calculate the number of days the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating FROM rental;

-- 2.2 Retrieve rental information with month and weekday columns, return 20 rows
SELECT 
    rental_id, rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday 
FROM rental 
LIMIT 20;

-- 2.3 Bonus: Add a column 'DAY_TYPE' categorizing rentals as 'weekend' or 'workday'
SELECT 
    rental_id, rental_date, 
    DAYNAME(rental_date) AS rental_weekday, 
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend' 
        ELSE 'workday' 
    END AS day_type 
FROM rental;

-- Challenge 3: Movie Accessibility Insights
-- Retrieve film titles and rental duration, replace NULL with 'Not Available'
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM film 
ORDER BY title ASC;

-- Bonus: Retrieve concatenated first and last names of customers, with first 3 characters of email
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    LEFT(email, 3) AS email_preview 
FROM customer 
ORDER BY last_name ASC;

-- Challenge 2: Film Insights
-- 1.1 Total number of films released
SELECT COUNT(*) AS total_films FROM film;

-- 1.2 Number of films per rating
SELECT rating, COUNT(*) AS film_count FROM film GROUP BY rating;

-- 1.3 Number of films per rating, sorted in descending order
SELECT rating, COUNT(*) AS film_count FROM film GROUP BY rating ORDER BY film_count DESC;

-- Challenge 2: Movie Duration Analysis
-- 2.1 Mean film duration for each rating, rounded to 2 decimal places
SELECT rating, ROUND(AVG(length), 2) AS avg_duration FROM film GROUP BY rating ORDER BY avg_duration DESC;

-- 2.2 Ratings with mean duration over 2 hours
SELECT rating, ROUND(AVG(length), 2) AS avg_duration FROM film GROUP BY rating HAVING avg_duration > 120;

-- Bonus: Identify last names that are not repeated in the actor table
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1;
