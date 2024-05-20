USE sakila;

-- 1.1
SELECT 
    MAX(length) AS max_duration, MIN(length) AS min_duration
FROM
    film;

-- 1.2 
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM
    film;

-- 2.1 
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM
    rental;

-- 2.2 
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    MONTH(rental_date) AS rental_month,
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
    staff_id,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1 , 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM
    rental
LIMIT 20;

-- 
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM
    film
ORDER BY title ASC;

-- PART #2 !!!

-- 1.1
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;



