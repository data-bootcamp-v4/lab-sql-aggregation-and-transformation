USE sakila;

-- Challenge 1

-- 1.1 Determine the shortest and longest movie durations

SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Express the average movie duration in hours and minutes

SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;

-- 2.1 Calculate the number of days that the company has been operating

SELECT DATEDIFF(
    MAX(rental_date),
    MIN(rental_date)
) AS operating_days
FROM rental;

-- 2.2 Retrieve rental information and add month and weekday

SELECT
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Classify rentals as weekend or workday

SELECT
    *,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3. Retrieve film titles and rental duration
-- Replace NULL values with 'Not Available'

SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. Retrieve concatenated customer names and
-- the first 3 characters of their email

SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_first_3
FROM customer
ORDER BY last_name ASC;

-- Challenge 2

-- 1.1 Determine the total number of films that have been released

SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 Determine the number of films for each rating

SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating, sorted in descending order

SELECT 
    rating, COUNT(*) AS number_of_films
FROM
    film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Mean film duration for each rating

SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with a mean duration of over two hours

SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- 3. Bonus: Determine which last names are not repeated in the actor table

SELECT
    last_name,
    COUNT(*) AS times_repeated
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
