USE Sakila;
-- CHALLENGE 1
-- EXERCISE 1
-- PART 1.1
SELECT 
    MAX(duration) AS max_duration,
    MIN(duration) AS min_duration
FROM film;
-- PART 1.2
SELECT 
    FLOOR(AVG(duration) / 60) AS avg_hours,
    ROUND(AVG(duration) % 60) AS avg_minutes
FROM film;

-- EXERCISE 2
-- PART 2.1
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
-- PART 2.2
SELECT 
    rental_id,
    customer_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- PART 2.3
SELECT 
    rental_id,
    customer_id,
    rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- EXERCISE 3
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- EXERCISE 4
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- CHALLENGE 2
-- EXERCISE 1
-- PART 1.1
SELECT COUNT(*) AS total_films
FROM film;
-- PART 1.2
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;
-- PART 1.3
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- EXERCISE 2
-- PART 2.1
SELECT rating, ROUND(AVG(duration), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
-- PART 2.2
SELECT rating, ROUND(AVG(duration), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

-- BONUS
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

