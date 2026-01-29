-- ==========================================================
-- Lab · SQL Aggregation & Transformation (Sakila)
-- Objetivo: rellenar cada apartado con tu query
-- ==========================================================

USE sakila;

-- ==========================================================
-- CHALLENGE 1 · Built-in functions + fechas + strings
-- ==========================================================

-- ==========================================================
-- 1) Movie duration insights
-- ==========================================================

-- 1.1 Shortest and longest movie durations (min_duration / max_duration)
-- TODO:

SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Average movie duration expressed in hours and minutes (no decimals)
-- Hint: FLOOR / ROUND
-- TODO:
SELECT
	ROUND(AVG(length), 0) AS avg_movie_duration
FROM film;

-- ==========================================================
-- 2) Rental dates insights
-- ==========================================================

-- 2.1 Number of days the company has been operating (DATEDIFF latest - earliest)
-- Hint: rental table + rental_date
-- TODO:
SELECT
	DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the 
-- month and weekday of the rental. Return 20 rows of results.
-- TODO:

SELECT
	r.*,
    MONTHNAME(r.rental_date) AS month_rental,
    DAYNAME(r.rental_date) AS weekday_rental
FROM rental AS r
WHERE rental_date LIKE '%%'
LIMIT 20;

-- 2.3 BONUS: add DAY_TYPE ('weekend'/'workday') depending on weekday
-- Hint: conditional expression (CASE)
-- TODO:
SELECT
	r.*,
    MONTHNAME(r.rental_date) AS month_rental,
	DAYNAME(r.rental_date) AS weekday_rental,
    CASE
		WHEN
			DAYNAME(r.rental_date) = 'Saturday' OR DAYNAME(r.rental_date) = 'Sunday' THEN 'weekend'
		ELSE
			'workday'
		END AS day_type
FROM rental AS r
WHERE rental_date LIKE '%%'
LIMIT 20;

-- ==========================================================
-- 3) Film titles + rental duration (handle NULL with IFNULL) + sort title ASC
-- ==========================================================
-- retrieve the film titles and their rental duration. If any rental duration value is 
-- **NULL, replace** it with the string **'Not Available'**. Sort the results of the film 
-- title in ascending order.
-- TODO:
SELECT
	title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration_clean
FROM film
ORDER BY
	title;

-- ==========================================================
-- 4) BONUS: marketing email: full name + first 3 chars of email, order by last_name ASC
-- Hint: CONCAT + SUBSTRING/LEFT
-- TODO:
SELECT
	CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS three_char_email
FROM customer
ORDER BY
	last_name;


-- ==========================================================
-- CHALLENGE 2 · Aggregations on film (counts/means) + sorting
-- ==========================================================

-- ==========================================================
-- 1) Film counts by rating
-- ==========================================================

-- 1.1 Total number of films released
-- TODO:
SELECT
	COUNT(film_id) AS num_films_released
FROM film;

-- 1.2 Number of films for each rating
-- TODO:
SELECT
	rating,
	COUNT(film_id) AS num_films
FROM film
GROUP BY
	rating;

-- 1.3 Number of films for each rating, sorted DESC by count
-- TODO:
SELECT
	rating,
	COUNT(film_id) AS num_films
FROM film
GROUP BY
	rating
ORDER BY
	num_films DESC;

-- ==========================================================
-- 2) Mean film duration by rating
-- ==========================================================

-- 2.1 Mean film duration for each rating, sorted DESC by mean (round to 2 decimals)
-- TODO:
SELECT
	rating,
    ROUND(AVG(length), 2) AS mean_film_duration
FROM film
GROUP BY
	rating
ORDER BY
	mean_film_duration DESC;

-- 2.2 Ratings with mean duration over 2 hours (over 120 minutes)
-- TODO:

SELECT
	rating,
    ROUND(AVG(length), 2) AS mean_film_duration
FROM film
GROUP BY
	rating
HAVING
	mean_film_duration > 120
ORDER BY
	mean_film_duration DESC;


-- ==========================================================
-- 3) BONUS: actor last names that are not repeated
-- TODO:
-- ==========================================================

SELECT
	last_name
FROM actor
GROUP BY
	last_name
HAVING COUNT(*) = 1;




