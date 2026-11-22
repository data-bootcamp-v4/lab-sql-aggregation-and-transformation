USE sakila;

-- Shortest and longest movie duration
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- Average movie duration in hours and minutes
SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

-- Number of days the company has been operating
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- Rental month and weekday
SELECT
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS month,
    DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;

-- Weekend or workday (bonus)
SELECT
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- Film titles and rental duration, NULLs replaced
SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Customer list for marketing campaign (bonus)
SELECT
    CONCAT(first_name, ' ', last_name) AS customer_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Total number of films
SELECT
	COUNT(*) AS total_films
FROM film;

-- Number of films per rating
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- Number of films per rating, sorted descending
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- Mean film duration per rating
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- Ratings with mean duration over two hours
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- Last names that appear only once (bonus)
SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;