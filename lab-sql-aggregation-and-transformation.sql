USE sakila;

-- Challenge 1.1
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

-- Challenge 1.2
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(MOD(AVG(length), 60)) AS avg_minutes
FROM film;

-- Challenge 1.2.1
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- Challenge 1.2.2
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Challenge 1.2.3
SELECT 
    rental_id,
    rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental;

-- Challenge 1.3
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Challenge 1.4
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2.1.1
SELECT 
    COUNT(*) AS total_films
FROM film;

-- Challenge 2.1.2
SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- Challenge 2.1.3
SELECT 
    rating,
    COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- Challenge 2.2.1
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- Challenge 2.2.2
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Challenge 2.2.2
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Challenge 2.3
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
