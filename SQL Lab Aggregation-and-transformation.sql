USE sakila;

-- challenge one
-- 1.1
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM 
    film;

-- 1.2

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM 
    film;
    
-- Number 2
-- 2.1

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM 
    rental;
    
-- 2.2

SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

-- 2.3

SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM 
    rental
LIMIT 20;

-- Number 3

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;
    
-- BONUS

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM 
    customer
ORDER BY 
    last_name ASC;
    
-- Challenge 2

-- Number one 
-- 1.1

SELECT 
    COUNT(*) AS total_films
FROM 
    film;

-- 1.2

SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating;
    
-- 1.3
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    number_of_films DESC;
    
-- Number two

-- 2.1

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    mean_duration DESC;
    
-- 2.2 

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM 
    film
GROUP BY 
    rating
HAVING 
    AVG(length) > 120
ORDER BY 
    mean_duration DESC;
    
-- Bonus

SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1;








