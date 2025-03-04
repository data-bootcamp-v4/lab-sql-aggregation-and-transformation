-- Use the Sakila database
USE sakila;

-- 1️⃣ Movie Duration Insights
-- 1.1 Determine the shortest and longest movie durations, naming them as max_duration and min_duration
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration 
FROM film;

-- 1.2 Express the average movie duration in hours and minutes (no decimals)
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60, 0) AS avg_minutes
FROM film;

-- 2️⃣ Rental Date Insights
-- 2.1 Calculate the number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating 
FROM rental;

-- 2.2 Retrieve rental information with additional columns for month and weekday, return 20 rows
SELECT 
    rental_id, customer_id, rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: Retrieve rental info with a new column 'DAY_TYPE' (weekend or workday)
SELECT 
    rental_id, customer_id, rental_date, 
    DAYNAME(rental_date) AS rental_weekday, 
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'Weekend'
        ELSE 'Workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3️⃣ Movie Collection Insights
-- Retrieve film titles and rental duration, replacing NULL values with 'Not Available'
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- 1️⃣ Film Count Analysis
-- 1.1 Determine the total number of films released
SELECT COUNT(*) AS total_films FROM film;

-- 1.2 Count the number of films for each rating
SELECT rating, COUNT(*) AS film_count 
FROM film 
GROUP BY rating;

-- 1.3 Count films for each rating, sorted in descending order
SELECT rating, COUNT(*) AS film_count 
FROM film 
GROUP BY rating 
ORDER BY film_count DESC;

-- 2️⃣ Film Duration Analysis
-- 2.1 Calculate the mean film duration for each rating, rounding to 2 decimal places
SELECT rating, ROUND(AVG(length), 2) AS avg_duration 
FROM film 
GROUP BY rating 
ORDER BY avg_duration DESC;

-- 2.2 Identify ratings where the mean film duration is over 120 minutes
SELECT rating, ROUND(AVG(length), 2) AS avg_duration 
FROM film 
GROUP BY rating 
HAVING avg_duration > 120;
