USE sakila ;
-- finding the min and max length of the film 
SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration 
FROM film;

-- finding the average film duration in hours and in  minutes 
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- the total number of days that the company has been operating, 
-- using the rental table and the DATEDIFF() function as requested:
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
-- finding the rental information along with the month and weekday, capped at 20 rows of results:
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- total number of film have been released:

SELECT COUNT(film_id) AS total_released_films 
FROM film;

-- To break the counts down by movie ratings (like G, PG, R, etc.), use the GROUP BY clause:
SELECT rating, COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating;


-- To prioritize the most common film ratings at the top of your list for purchasing insights,
-- add an ORDER BY clause pointing to your film count alias:
SELECT rating, COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- To calculate the average runtime for each rating group, 
-- we use AVG() along with the ROUND() function to clean up the decimal points.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- To filter groups based on an aggregate calculation like an average, 
-- you must use the HAVING clause instead of a standard WHERE clause.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Determine which last names are not repeated in the actor table

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;








