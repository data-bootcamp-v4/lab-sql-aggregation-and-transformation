USE sakila;
-- Challenge 1
-- 1.
SELECT MAX(length) AS max_duration,
       MIN(length) AS min_duration
FROM sakila.film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length)) % 60 AS avg_minutes
FROM film;
-- 2.
SELECT 
    DATEDIFF(
        MAX(rental_date),
        MIN(rental_date)
    ) AS operating_days
FROM rental;

SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date)   AS rental_weekday
FROM rental
LIMIT 20;

SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;
-- 3.
SELECT 
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration_display
FROM film
ORDER BY title ASC;
-- 4.
SELECT CONCAT(first_name,' ',last_name) AS customer_name,
       SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC, first_name ASC;

-- Challenge 2
-- 1.
SELECT 
    COUNT(*) AS total_films
FROM film;

SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating;
-- 2.
SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_length_minutes
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_length_minutes DESC;

-- 3.
SELECT 
    first_name,
    last_name
FROM actor
WHERE last_name IN (
    SELECT last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(*) = 1
)
ORDER BY last_name, first_name;



