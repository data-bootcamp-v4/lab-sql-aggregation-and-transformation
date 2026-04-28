USE sakila;

-- Challenge 1
-- 1.1
SELECT
MAX(length) AS max_duration,
MIN(length) AS min_duration
FROM film;

-- 1.2
SELECT 
    CONCAT(
        FLOOR(AVG(length) / 60), 'h ', 
        ROUND(AVG(length) % 60), 'm'
    ) AS average_duration
FROM film;

-- 2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2
SELECT *, 
       MONTHNAME(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3
SELECT *, 
	CASE
       WHEN DAYNAME(rental_date) IN ('Sunday', 'Saturaday') THEN 'Weekend'
       ELSE 'workday'
       END AS day_type
FROM rental;

-- 3
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Challenge 2
-- 1.1
SELECT COUNT(title) AS total_released_films
FROM film;

-- 1.2
SELECT rating, COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3
SELECT rating, COUNT(film_id) AS number_of_films
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

-- 2.1
SELECT rating, ROUND(AVG(length),2) AS mean_duration
FROM film 
GROUP BY rating
ORDER BY AVG(length) DESC;

-- 2.2
SELECT rating, ROUND(AVG(length),2) AS mean_duration
FROM film 
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY AVG(length) DESC;
