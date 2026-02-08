SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration 
FROM sakila.film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM sakila.film;

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_in_operation
FROM sakila.rental;

SELECT 
    rental_id,
    rental_date,
    EXTRACT(MONTH FROM rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM sakila.rental
LIMIT 20;

SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;