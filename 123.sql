use sakila;

select max(length) as max_duration, min(length) as min_duration
from film;

select 
    floor(AVG(length) / 60) as hours,
    floor(AVG(length) % 60) as minutes
from film;

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT 
    rental_id,
    rental_date,
    monthname(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'  -- Sunday=1, Saturday=7 in MySQL
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

select concat (first_name, ' ',last_name) as Full_name, left(email,3)
from customer
order by last_name asc;

SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_length_min
FROM film
GROUP BY rating
ORDER BY mean_length_min DESC;

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_length_min
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_length_min DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;



