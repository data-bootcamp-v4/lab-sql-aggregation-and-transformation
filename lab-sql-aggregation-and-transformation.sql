USE sakila;
-- CHALLENGE 1

-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT
MAX(length) AS max_duration,
MIN(length) AS min_duration
FROM film;

-- Express the average movie duration in hours and minutes. Don't use decimals.
SELECT
FLOOR(AVG(length)/60) AS hours,
ROUND(AVG(length) % 60) AS minutes
FROM film;

-- Calculate the number of days that the company has been operating.
SELECT
DATEDIFF(MAX(rental_date),MIN(rental_date)) AS operating_days
FROM rental;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
rental_id,
rental_date,
MONTH(rental_date) AS rental_month,
WEEKDAY(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- BONUS: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT 
    rental_id,
    rental_date,
    CASE -- creates custom values 'weekend' for Saturday/Sunday and 'workday' for Monday–Friday.
        WHEN WEEKDAY(rental_date) IN (5, 6) THEN 'weekend'-- WEEKDAY(rental_date) → returns day numbers (0 = Monday, 6 = Sunday).IN (5, 6) → checks for Saturday and Sunday.
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

-- Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT
title,
IFNULL(rental_duration,"Not Available") AS rental_duration
FROM film
ORDER BY title ASC;

-- CHALLENGE 2

-- The total number of films that have been released.
SELECT COUNT(*)AS tootal_films
FROM film;

-- The number of films for each rating.
SELECT 
rating,
COUNT(*) AS number_of_films
from film
GROUP BY rating;

-- The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT
rating,
COUNT(*) AS number_of_films
FROM film 
GROUP BY rating
ORDER BY number_of_films DESC;

-- The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT 
rating,
ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT
rating,
ROUND(AVG(length),2) AS mean_duration
FROM film 
GROUP BY rating
HAVING AVG(length) > 120;

 