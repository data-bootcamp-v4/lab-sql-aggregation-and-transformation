USE sakila;
--- Determine the shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
 
SELECT CONCAT(
    FLOOR(AVG(`length`) / 60),
    ' hours ',
    FLOOR(MOD(AVG(`length`), 60)),
    ' minutes'
) AS average_duration
FROM film;
-- Calculate the number of days that the company has been operating
SELECT DATEDIFF(max(rental_date), MIN(rental_date)) AS "Company age (days)"
FROM rental;
-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT monthname(rental_date) AS "Month of rental", 
dayname(rental_date) AS "Day of rental"
FROM rental LIMIT 20;
-- 3. Replace NULL
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
-- Number of films released

SELECT COUNT(*) AS number_of_films
FROM film;
--  The number of films for each rating.
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;
-- The number of films for each rating, sorting the results in descending order of the number of films.
-- The number of films for each rating, sorted from most films to fewest films
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;
-- The mean film duration for each rating,
SELECT 
    rating,
    ROUND(AVG(length), 2) AS film_duration
FROM film
GROUP BY rating
ORDER BY film_duration DESC;
--  Identify which ratings have a mean duration of over two hours
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

