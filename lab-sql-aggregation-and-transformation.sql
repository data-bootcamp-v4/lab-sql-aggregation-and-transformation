USE sakila;

-- ===================== Challenge 1 =====================

-- 1.1 Shortest and longest movie durations
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes, no decimals
SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.1 Number of days the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Rental info + month and weekday columns, 20 rows
SELECT *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: DAY_TYPE = 'weekend' or 'workday'
SELECT *,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3. Film titles + rental duration, NULL -> 'Not Available', sorted by title ascending
-- (no NULLs currently in this column, but IFNULL keeps the query correct if that changes)
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- BONUS 4. Concatenated customer name + first 3 characters of their email, by last name ascending
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- ===================== Challenge 2 =====================

-- 1.1 Total number of films released
SELECT COUNT(*) AS total_films FROM film;

-- 1.2 Number of films per rating
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;

-- 1.3 Same, sorted descending by number of films
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

-- 2.1 Mean film duration per rating, sorted descending, rounded to 2 decimals
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with a mean duration over two hours (120 minutes)
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;   -- only PG-13 qualifies (120.44)

-- BONUS 3. Last names that appear exactly once in the actor table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
