USE sakila;
SELECT
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;
SELECT
    FLOOR(SUM(length) / 60) AS avg_hours,
    SUM(length) % 60 AS avg_minutes
FROM film;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS num_days
FROM rental;
SELECT
    rental_id,
    rental_date,
    MONTH(rental_date) AS month,
    DATENAME(DW, rental_date) AS day_week
FROM rental
LIMIT 20;
SELECT
    rental_id,
    rental_date,
    DATENAME(DW, rental_date) AS day_week,
    CASE
        WHEN DATENAME(DW, rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;
SELECT
    title,
    IFNULL(CONCAT(length, ' minutes'), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT(LEFT(email, 3), '...') AS email_prefix
FROM
    customer;
SELECT COUNT(*) AS total_films_released
FROM film;
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120
ORDER BY avg_duration DESC;
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;