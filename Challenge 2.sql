USE sakila;

-- Total number of films released

SELECT COUNT(*) AS total_films
FROM film;

-- Number of films for each rating
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- Number of films for each rating (sorted descending)
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;


-- Mean film duration for each rating (rounded to 2 decimals)

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- Ratings with mean duration over 2 hours (120 minutes)

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- Last names that are not repeated in actor table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;  -- or: HAVING COUNT(last_name)
