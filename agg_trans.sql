SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(MOD(AVG(length), 60)) AS avg_minutes
FROM film;

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;


SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;


SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


SELECT COUNT(*) AS total_films
FROM film;

SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;


SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

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