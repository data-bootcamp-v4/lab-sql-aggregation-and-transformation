USE sakila;
-- 1.1 Shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM film;

-- 2.1 Number of days the company has been operating
SELECT DATEDIFF(
    MAX(rental_date),
    MIN(rental_date)
) AS operating_days
FROM rental;

-- 2.2 Rental information with month and weekday
SELECT *,
       MONTHNAME(rental_date) AS rental_month,
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Add DAY_TYPE as weekend or workday
SELECT *,
       MONTHNAME(rental_date) AS rental_month,
       DAYNAME(rental_date) AS rental_weekday,
       CASE
           WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday')
           THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental
LIMIT 20;

-- Challenge 1 - 3
SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Challenge 1 - 4 Bonus
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2 - 1.1 Total number of films
SELECT COUNT(*) AS total_films
FROM film;

-- Challenge 2 - 1.2 Number of films for each rating
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- Challenge 2 - 1.3 Number of films for each rating, descending
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- Challenge 2 - 2.1 Mean film duration for each rating
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- Challenge 2 - 2.2 Ratings with mean duration over 2 hours
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Challenge 2 - 3 Bonus
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;