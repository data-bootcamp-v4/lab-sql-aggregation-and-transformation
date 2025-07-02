use sakila;
SHOW tables
-- 1.1 
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

-- 1.2
SELECT 
    CONCAT(
        FLOOR(AVG(length)/60), ' hours ',
        ROUND(AVG(length)%60), ' minutes'
    ) AS avg_duration
FROM film;

-- 2.1
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
-- 2.2
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 3
SELECT 
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- Challenge 2 1.1
SELECT COUNT(*) AS total_films
FROM film;

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
SELECT rating, ROUND(AVG(length), 2) AS duration
FROM film
GROUP BY rating
ORDER BY duration DESC;

-- 2.2
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;
