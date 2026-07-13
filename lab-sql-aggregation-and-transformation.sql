USE Sakila 

-- CHALLENGE 1
SELECT MAX(length) AS max_lenght
FROM film;
-- Max: 185

SELECT MIN(length) AS min_lenght
FROM film;
-- Min: 46

SELECT FLOOR(AVG(length)/60) AS hours,
	ROUND(AVG(length)% 60) AS minutes

FROM 
	film;
-- Avg: 1 Hs 55 min

-- 2 Rent dates

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

SELECT *
FROM rental;

SELECT
    rental_id,
    rental_date,
    MONTH(rental_date) AS month,
    DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;

--  film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT*
FROM film;

SELECT
    film.rental_duration,
    CASE
        WHEN film_text.film_id IS NULL THEN 'Not Available'
        ELSE film_text.title
    END AS title
FROM 
    film
LEFT JOIN 
    film_text ON film.film_id = film_text.film_id;
    
    -- CHALLENGE 2
    SELECT COUNT(DISTINCT(film_id)) AS unique_film
    FROM film;
    
SELECT
	rating,
	COUNT(*) AS rating_quantity
FROM film
GROUP BY rating
ORDER BY rating_quantity DESC;

SELECT
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_duration DESC;