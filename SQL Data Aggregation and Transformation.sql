USE sakila;
SHOW TABLES;

-- 1
SELECT MAX(length) AS max_duration FROM sakila.film;
SELECT MIN(length) AS min_duration FROM sakila.film;

SELECT FLOOR(AVG(length) / 60) as avg_hours,
ROUND((AVG(length) % 60)) AS avg_minutes
FROM film;

SELECT CONCAT(
        FLOOR(AVG(length) / 60), 'h', 
        ROUND(AVG(length) % 60)
    ) AS avg_duration
FROM film;

-- 2

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

SELECT * FROM rental;

SELECT 
    rental_id, 
    rental_date, 
    EXTRACT(MONTH FROM rental_date) AS rental_month, 
    WEEKDAY(rental_date) AS rental_weekday
FROM rental
LIMIT 20;


-- 3
SELECT 
    title, 
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- 4
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;



-- challenge 2
-- 1
SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;