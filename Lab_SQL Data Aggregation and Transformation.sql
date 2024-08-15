USE sakila;

SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

SELECT 
    CONCAT(
        FLOOR(AVG(length) / 60), ' hours ',
        LPAD(AVG(length) % 60, 2, '0'), ' minutes'
    ) AS average_duration
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT 
    rental_id, rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT 
    rental_id, rental_date, 
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

SELECT 
    title AS film_title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title;

SELECT 
    CONCAT(first_name, ' ', last_name) AS customer_name, 
    LEFT(email, 3) AS first_three_chars
FROM customer
ORDER BY last_name;

SELECT COUNT(*) AS total_films_released
FROM film;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

SELECT 
    rating, 
    AVG(length) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

SELECT COUNT(*)
FROM (
    SELECT last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(*) = 1
) AS unique_last_names;