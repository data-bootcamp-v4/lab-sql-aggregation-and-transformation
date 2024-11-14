use sakila;

SELECT
	min(length) as min_duration,
    max(length) as max_duration
from film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

SELECT
	datediff(
	max(rental_date),
	min(rental_date))
    as operating_date
from rental;

SELECT 
    rental_id, 
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    MONTH(rental_date) AS rental_month,
    DAYOFWEEK(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT 
    rental_id, 
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    MONTH(rental_date) AS rental_month,
    DAYOFWEEK(rental_date) AS rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

select count(release_year) from film;
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films;

SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;