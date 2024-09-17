USE sakila;

-- This query returns the maximum (max_duration) and minimum (min_duration) movie lengths from the film table
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration 
FROM film;

-- This query calculates the average movie duration and expresses it in hours and minutes, without decimals.
SELECT 
    FLOOR(AVG(length) / 60) AS hours, 
    FLOOR(AVG(length) % 60) AS minutes 
FROM film;

-- This query calculates the number of days between the first and last rental date in the rental table, providing the total operational days.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating 
FROM rental;

-- This query retrieves rental information along with the rental month and weekday, limited to 20 rows.
SELECT 
    rental_id, 
    rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday 
FROM rental 
LIMIT 20;

-- This query adds a DAY_TYPE column to indicate whether the rental occurred on a weekend or workday.
SELECT 
    rental_id, 
    rental_date, 
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend' 
        ELSE 'workday' 
    END AS day_type 
FROM rental 
LIMIT 20;

-- This query retrieves film titles and rental durations, replacing any NULL values in rental_duration with "Not Available".
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM film 
ORDER BY title ASC;

-- This query concatenates customers' first and last names and extracts the first three characters of their email addresses, ordering the results by last name.
SELECT 
    CONCAT(first_name, ' ', last_name) AS customer_name, 
    SUBSTRING(email, 1, 3) AS email_prefix 
FROM customer 
ORDER BY last_name ASC;

-- This query returns the total number of films in the film table.
SELECT COUNT(*) AS total_films 
FROM film;

-- This query returns the number of films for each rating.
SELECT 
    rating, 
    COUNT(*) AS film_count 
FROM film 
GROUP BY rating;

-- This query counts the number of films per rating and sorts the results in descending order.
SELECT 
    rating, 
    COUNT(*) AS film_count 
FROM film 
GROUP BY rating 
ORDER BY film_count DESC;

-- This query calculates the mean film duration for each rating and sorts the results by mean duration in descending order.
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
ORDER BY mean_duration DESC;

-- This query filters ratings where the mean film duration is greater than two hours (120 minutes).
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
HAVING AVG(length) > 120;

-- This query retrieves last names from the actor table that appear only once, ensuring no repeated last names.
SELECT last_name 
FROM actor 
GROUP BY last_name 
HAVING COUNT(last_name) = 1;