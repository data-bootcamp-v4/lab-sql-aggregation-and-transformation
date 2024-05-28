use sakila;
-- Challenge 1: Movie Duration Insights

-- 1.1 Determine the shortest and longest movie durations
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Express the average movie duration in hours and minutes
SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- Challenge 2: Rental Date Insights

-- 2.1 Calculate the number of days that the company has been operating
SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Retrieve rental information with month and weekday columns, returning 20 rows
SELECT
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Add a column called DAY_TYPE indicating 'weekend' or 'workday'
SELECT
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday,
    CASE
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- Challenge 3: Film Titles and Rental Duration

-- Retrieve film titles and their rental duration, replacing NULL values with 'Not Available', and sorting titles in ascending order
SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;