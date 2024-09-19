USE sakila;
-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration
FROM 
    film;
    
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.

SELECT 
    FLOOR(AVG(length) / 60) AS hours, 
    MOD(AVG(length), 60) AS minutes
FROM 
    film;

-- Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM 
    rental;
    
-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT month(rental_date), DAY(rental_date) AS days_operating
FROM rental
LIMIT 20;

-- Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT 
    rental_date, 
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM 
    rental;
-- retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
SELECT title,
IFNULL(rental_duration, 'Not available') AS rental_duration
FROM film;

-- CHALLENGE 2
-- The total number of films that have been released.
SELECT COUNT(*) AS total_films
FROM film;

SELECT release_year, COUNT(*) AS total_films
FROM film
GROUP BY release_year;

-- The number of films for each rating.
SELECT rating, count(*) AS total_films
FROM film 
GROUP BY rating;

SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

-- The mean film duration for each rating
SELECT rating,
AVG(length) AS duration_mean_rating
FROM film 
GROUP BY rating;

-- which ratings have a mean duration of over two hours in order to help 
-- select films for customers who prefer longer movies.
SELECT rating,
AVG(length) AS duration_mean_rating
FROM film 
GROUP BY rating
HAVING AVG(length) > 120;



