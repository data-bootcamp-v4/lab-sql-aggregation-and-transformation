-- ===============================================================================================================
USE sakila;
-- ===============================================================================================================
-- CHALLENGE 2
-- ===============================================================================================================
-- 1. Next, you need to analyze the *films* in the collection to gain some more insights. 
-- Using the `film` table, determine:
	-- 1.1 The **total number of films** that have been released.
	-- 1.2 The **number of films for each rating**.
	-- 1.3 The **number of films for each rating, sorting** the results in descending order of the number of films.
-- This will help you to better understand:
-- the popularity of different film ratings and adjust purchasing decisions accordingly.
-- ---------------------------------------------------------------------------------------------------------------
SELECT * FROM film;
-- 1.1 The **total number of films** that have been released.
SELECT COUNT(film_id) FROM film;
SELECT COUNT(DISTINCT film_id) FROM film; -- the count is 1000 films released
--
-- 1.2 The **number of films for each rating**.
SELECT 
    rating,
    COUNT(*) AS nbr_films
FROM film
GROUP BY rating;
--
-- 1.3 The **number of films for each rating, sorting** the results in *descending* order of the number of films.
SELECT 
    rating,
    COUNT(*) AS nbr_films
FROM film
GROUP BY rating
ORDER BY nbr_films DESC;
-- ===============================================================================================================
-- 2. Using the `film` table, determine:
	-- 2.1 The **mean film duration for each rating**, 
		-- and sort the results in descending order of the mean duration. 
		-- Round off the average lengths to two decimal places. 
		-- This will help identify popular movie lengths for each category.

	-- 2.2 Identify **which ratings have a mean duration of over two hours** 
		-- in order to help select films for customers who prefer longer movies.
-- -----------------------------------------------------------------------------------------------------------
-- 2.1 
-- mean_duration for each rating
-- sort ORDER BY mean_duration DESC
-- round average lengths to two decimal places
SELECT
    rating,
    ROUND(AVG(rental_duration), 2) AS mean_duration,  -- mean rental duration, rounded
    ROUND(AVG(length), 2) AS avg_length               -- average film length, rounded
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

--
-- 2.2 
-- Identify **which ratings have mean_duration above two hours** 
SELECT
    rating,
    ROUND(AVG(rental_duration), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(rental_duration) > 2
ORDER BY mean_duration DESC;
--
--
SELECT *
FROM (
    SELECT
        rating,
        ROUND(AVG(rental_duration), 2) AS mean_duration
    FROM film
    GROUP BY rating
) AS t
WHERE mean_duration > 2
ORDER BY mean_duration DESC;
-- ===============================================================================================================
-- 3. *Bonus: determine which last names are not repeated in the table `actor`.*
SELECT DISTINCT last_name FROM actor;
SELECT COUNT(last_name) FROM actor; -- 200 total rows
SELECT COUNT(DISTINCT last_name) FROM actor; -- 121 unique last_name
--
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
-- 
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;
-- 
SELECT COUNT(*) AS nbr_unique_last_names
FROM (
    SELECT last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(*) = 1
) AS t;
-- ===============================================================================================================