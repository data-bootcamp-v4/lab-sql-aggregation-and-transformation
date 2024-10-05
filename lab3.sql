-- Challenge 1: Movie Duration Insights

-- 1.1 Determine the shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration 
FROM 
    film;

-- 1.2 Express the average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes 
FROM 
    film;

-- Insights Related to Rental Dates

-- 2.1 Calculate the number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operational_days 
FROM 
    rental;

-- 2.2 Retrieve rental information with month and weekday of rental
SELECT 
    rental_id, 
    rental_date, 
    MONTH(rental_date) AS rental_month, 
    DAYOFWEEK(rental_date) AS rental_weekday 
FROM 
    rental 
LIMIT 20;

-- 2.3 Bonus: Add DAY_TYPE column
SELECT 
    rental_id, 
    rental_date, 
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE 
FROM 
    rental;

-- 3. Retrieve film titles and rental duration (handling NULLs)
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM 
    film 
ORDER BY 
    title ASC;

-- Bonus: Retrieve concatenated names and email characters
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    SUBSTRING(email, 1, 3) AS email_prefix 
FROM 
    customer 
ORDER BY 
    last_name ASC;

-- Challenge 2: Film Collection Analysis

-- 1.1 Total number of films released
SELECT 
    COUNT(*) AS total_films 
FROM 
    film;

-- 1.2 Number of films for each rating
SELECT 
    rating, 
    COUNT(*) AS number_of_films 
FROM 
    film 
GROUP BY 
    rating;

-- 1.3 Number of films for each rating (sorted in descending order)
SELECT 
    rating, 
    COUNT(*) AS number_of_films 
FROM 
    film 
GROUP BY 
    rating 
ORDER BY 
    number_of_films DESC;

-- 2.1 Mean film duration for each rating
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration 
FROM 
    film 
GROUP BY 
    rating 
ORDER BY 
    mean_duration DESC;

-- 2.2 Ratings with a mean duration of over two hours
SELECT 
    rating 
FROM 
    film 
GROUP BY 
    rating 
HAVING 
    AVG(length) > 120;

-- Bonus: Last names not repeated in the actor table
SELECT 
    last_name 
FROM 
    actor 
GROUP BY 
    last_name 
HAVING 
    COUNT(*) = 1;
