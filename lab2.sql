-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;

-- Insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    WEEKDAY(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Add an additional column called DAY_TYPE with values 'weekend' or 'workday'.
SELECT 
    rental_id,
    rental_date,
    CASE 
        WHEN WEEKDAY(rental_date) IN (5, 6) THEN 'weekend' 
        ELSE 'workday' 
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- Ensure customers can easily access information about the movie collection:
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Bonus: Retrieve concatenated names and email information.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 1 - Analyze films in the collection:

-- 1.1 The total number of films that have been released.
SELECT 
    COUNT(*) AS total_films
FROM film;

-- 1.2 The number of films for each rating.
SELECT 
    rating, 
    COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting results in descending order.
SELECT 
    rating, 
    COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating 
ORDER BY number_of_films DESC;

-- 2.1 The mean film duration for each rating, sorted in descending order of mean duration.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours.
SELECT 
    rating 
FROM film 
GROUP BY rating 
HAVING AVG(length) > 120;

-- Bonus: Determine which last names are not repeated in the table actor.
SELECT 
    last_name 
FROM actor 
GROUP BY last_name 
HAVING COUNT(*) = 1;