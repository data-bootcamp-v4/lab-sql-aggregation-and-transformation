use sakila;

-- CHALLENGE 1

-- 1.1

select
	min(length) as min_duration,
	max(length) as max_duration
from film;

-- 1.2

select
	floor(avg(length) / 60) as avg_hours,
    round(mod(avg(length), 60)) as avg_minutes
from film;

-- 2.1

select 
    datediff(max(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2

SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 3.

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- CHALLENGE 2

-- 1.1

SELECT COUNT(*) AS total_films FROM film;

-- 1.2

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- 1.3

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;


-- 2.1

SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2

SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_duration DESC;