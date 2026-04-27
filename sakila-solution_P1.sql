-- sakila_solution_P1.sql

-- Part 1: Max and Min durations
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration 
FROM film;

-- Avg duration in h/min -- % is the modulo operator
SELECT 
    FLOOR(AVG(length) / 60) AS hours, 
    ROUND(AVG(length) % 60) AS minutes 
FROM film;

-- Part 2: Total days of company operations -- use 'datediff'
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days 
FROM rental;

-- Top 20 Months and weekdays for rental
SELECT *, 
    MONTHNAME(rental_date) AS month, 
    DAYNAME(rental_date) AS weekday 
FROM rental 
LIMIT 20;

-- Bonus: Workday vs Weekend -- CASE =if/elif statement
SELECT *, 
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

-- Part 3: Handling Null values

SELECT title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM film 
ORDER BY title ASC;

-- Bonus: Concatenation -- LEFT(str, 3) =Slice method str[:3]
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    LEFT(email, 3) AS email_prefix 
FROM customer 
ORDER BY last_name ASC;