USE sakila;
-- Challenge 1
-- 1
-- 1.1
SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration
FROM 
    film;

-- 1.2
SELECT 
    FLOOR(AVG(length) / 60) AS average_hours,
    ROUND(AVG(length) % 60) AS average_minutes
FROM 
    film;
    
-- 2
-- 2.1
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM 
    rental;

-- 2.2
SELECT 
    rental_id,
    inventory_id,
    customer_id,
    staff_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

-- 2.3
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    staff_id,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'  -- 1 = Sunday, 7 = Saturday
        ELSE 'workday'
    END AS DAY_TYPE
FROM 
    rental
LIMIT 20;


-- 3
select
	film.title,
	ifnull(datediff(return_date, rental_date),'Not Available') as rental_duration
from
	rental,
    film;
    
-- 4
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    LEFT(c.email, 3) AS email_prefix
FROM 
    customer c
ORDER BY 
    c.last_name ASC;
    
-- Challenge 2
-- 2
SELECT 
    COUNT(*) AS total_films
FROM 
    film;
    
SELECT 
    rating, 
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating;

SELECT 
    rating, 
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    number_of_films DESC;


-- 2
select 
	rating,
	round(avg(length)) as avg_length
from
	film
GROUP BY 
    rating
ORDER BY 
    avg_length DESC;

SELECT 
    rating,
    AVG(length) AS average_duration
FROM 
    film
GROUP BY 
    rating
HAVING 
    AVG(length) > 120;


-- 3
SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1;
