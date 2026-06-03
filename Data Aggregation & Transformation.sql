USE sakila;

-- Challenge 1.1
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- Challenge 1.2
SELECT 
    CONCAT(
        FLOOR(AVG(length) / 60), ' hours ',
        ROUND(AVG(length) % 60), ' minutes'
    ) AS average_duration
FROM film;

-- Challenge 1.2.1
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- Challenge 1.2.2
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Challenge 1.2.3 Bonus
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- Challenge 1.3
SELECT 
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Challenge 1.4 Bonus
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_start
FROM customer
ORDER BY last_name ASC;

-- Challenge 2.1.1
SELECT 
    COUNT(*) AS total_films
FROM film;

-- Challenge 2.1.2
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- Challenge 2.1.3
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- Challenge 2.2.1
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- Challenge 2.2.2
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- Challenge 2.3 Bonus
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;