USE sakila;
-- 1.1 Shortest and longest durations
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration 
FROM film;

-- 1.2 Average duration in hours and minutes
-- Floor(length/60) gives hours, length % 60 gives the remaining minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60) AS avg_minutes 
FROM film;
-- 2.1 Total operating days
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days 
FROM rental;

-- 2.2 Month and Weekday (Top 20)
-- We use MONTHNAME and DAYNAME functions
SELECT *, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: Workday vs Weekend
-- WEEKDAY() returns 0-4 for Mon-Fri and 5-6 for Sat-Sun
SELECT *, 
    CASE 
        WHEN WEEKDAY(rental_date) >= 5 THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;
-- Replace NULL rental durations
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- BONUS: Personalized Marketing
-- CONCAT joins strings, LEFT(email, 3) grabs the first 3 letters
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;
-- 1.1 Total films
SELECT COUNT(*) FROM film;

-- 1.2 & 1.3 Films per rating (sorted)
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;
-- 2.1 Mean duration per rating
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with mean duration > 120 minutes
-- Use HAVING because we are filtering an aggregate (AVG)
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

-- BONUS: Unique last names in actor table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;