-- CHALLENGE 1
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration 
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    CONCAT(
        FLOOR(AVG(length) / 60), ' hours ', 
        ROUND(AVG(length) % 60), ' minutes'
    ) AS avg_duration 
FROM film;

-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
    rental_id, 
    rental_date, 
    DATE_FORMAT(rental_date, '%M') AS rental_month, 
    DATE_FORMAT(rental_date, '%W') AS rental_weekday 
FROM rental 
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT 
    rental_id, 
    rental_date, 
    DATE_FORMAT(rental_date, '%W') AS rental_weekday, 
    CASE 
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend' 
        ELSE 'workday' 
    END AS DAY_TYPE 
FROM rental 
LIMIT 20;

-- 3 
SELECT 
    title, 
    CASE 
        WHEN rental_duration IS NULL THEN 'Not Available' 
        ELSE rental_duration 
    END AS rental_duration 
FROM film 
ORDER BY title ASC;

-- CHALANGE 2

-- 1.1 The total number of films that have been released.
SELECT COUNT(*) AS total_films 
FROM film;

-- 1.2 The number of films for each rating
SELECT rating, COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating;

-- 1.3 The number of films for each rating, sorted in descending order of the number of films
SELECT rating, COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 The mean film duration for each rating, sorted in descending order of the mean duration
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
HAVING mean_duration > 120;

-- Bonus: determine which last names are not repeated in the table actor
SELECT last_name
FROM actor 
GROUP BY last_name 
HAVING COUNT(*) = 1 ;