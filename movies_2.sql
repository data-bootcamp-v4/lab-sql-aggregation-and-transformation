USE sakila;
-- 1.1
SELECT MIN(length) AS min_duration,MAX(length) AS max_duration
FROM film;
-- 1.2
SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(MOD(AVG(length), 60)) AS minutes
FROM film;
-- 2
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
-- 2.1
SELECT rental_id, rental_date, MONTH(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday
FROM rental LIMIT 20;
-- 2.3
SELECT *, DAYNAME(rental_date) AS weekday, CASE WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental 
LIMIT 20;
-- 3
SELECT title, COALESCE(CONVERT(rental_duration, CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
-- 4
SELECT CONCAT(first_name, ' ', last_name) AS full_name, SUBSTRING(email, 1, 3) AS email_start
FROM customer
ORDER BY last_name ASC;

-- 5
SELECT COUNT(*) AS total_films FROM film;
-- 5.1
SELECT rating, COUNT(*) AS film_count FROM film
GROUP BY rating;
-- 5.2
SELECT rating, COUNT(*) AS film_count FROM film
GROUP BY rating
ORDER BY film_count DESC;
-- 6
SELECT rating, ROUND(AVG(length), 2) AS avg_duration FROM film
GROUP BY rating
ORDER BY avg_duration DESC;
-- 6.1
SELECT rating, ROUND(AVG(length), 2) AS avg_duration FROM film
GROUP BY rating
HAVING AVG(length) > 120;
-- 7
SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;