-- Selecting the sakila database to run all queries on it
USE sakila;
-- Getting the maximum and minimum movie duration from the film table
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
-- Calculating the average movie duration and converting it into hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;
-- Calculating the number of days between the earliest and latest rental dates
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
-- Showing 10 sample rows from the rental table
SELECT 
    rental_id,
    rental_date,
    return_date
FROM rental
LIMIT 10;
-- Showing film titles and rental duration, replacing NULL values with 'Not Available'
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title;
-- Counting the total number of films in the film table
SELECT COUNT(*) AS total_films
FROM film;
-- Counting how many films exist for each rating
SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating;
-- Sorting the film count per rating from highest to lowest
SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;
-- Calculating the average film duration for each rating, rounded to 2 decimals
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;
-- Showing only the ratings where the average film duration is more than 120 minutes
SELECT 
    rating,
    AVG(length) AS avg_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120;
