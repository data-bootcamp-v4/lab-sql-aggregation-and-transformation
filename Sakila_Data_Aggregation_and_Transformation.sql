USE sakila;
-- Determine the shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration 
FROM film;

-- Express the average movie duration in hours and minutes (no decimals)
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60, 0) AS avg_minutes 
FROM film;

-- Insights Related to Rental Dates
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating 
FROM rental;


-- Retrieve rental information and add columns for month and weekday (20 rows)
SELECT 
    rental_id, customer_id, rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday 
FROM rental 
LIMIT 20;

--  Add a DAY_TYPE column with 'weekend' or 'workday'
SELECT 
    rental_id, customer_id, rental_date, 
    DAYNAME(rental_date) AS rental_weekday, 
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' 
        ELSE 'workday' 
    END AS day_type 
FROM rental 
LIMIT 20;

-- Customer-Friendly Movie Collection Info
-- Retrieve film titles and rental duration, replacing NULL values with 'Not Available'
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM film 
ORDER BY title ASC;


-- Concatenate first and last names with the first 3 characters of the email
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    LEFT(email, 3) AS email_prefix 
FROM customer 
ORDER BY last_name ASC;

-- Film Collection Analysis
-- Total number of films released
SELECT COUNT(*) AS total_films FROM film;

-- Number of films per rating
SELECT rating, COUNT(*) AS num_films 
FROM film 
GROUP BY rating;

-- Number of films per rating sorted in descending order
SELECT rating, COUNT(*) AS num_films 
FROM film 
GROUP BY rating 
ORDER BY num_films DESC;


-- Film Duration Analysis
-- Mean film duration for each rating (rounded to 2 decimal places, sorted in descending order)
SELECT rating, ROUND(AVG(length), 2) AS avg_duration 
FROM film 
GROUP BY rating 
ORDER BY avg_duration DESC;

-- Identify ratings with a mean duration over 2 hours (120 minutes)
SELECT rating, ROUND(AVG(length), 2) AS avg_duration 
FROM film 
GROUP BY rating 
HAVING avg_duration > 120;

-- Determine last names that are not repeated in the actor table
SELECT last_name 
FROM actor 
GROUP BY last_name 
HAVING COUNT(*) = 1;
