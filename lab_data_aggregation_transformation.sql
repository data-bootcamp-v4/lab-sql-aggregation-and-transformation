-- ======================================
-- CHALLENGE 1
-- ======================================

-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM film;

-- Express the average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

-- Calculate the number of days that the company has been operating.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
    rental_id, 
    rental_date, 
    MONTH(rental_date) AS month, 
    DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;

-- ======================================
-- CHALLENGE 2
-- ======================================

-- The total number of films that have been released.
SELECT COUNT(*) AS total_films
FROM film;

-- The number of films for each rating.
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;

-- The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC; 

-- The mean film duration for each rating, and sort the results in descending order of the mean duration
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

