USE sakila;
SELECT 
      MAX(length) As max_duration,
	  MIN(length) As min_duration
FROM film;
-- Challenge 1, Exercise 1.2
-- Express the average movie duration in hours and minutes

SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(MOD(AVG(length), 60)) AS minutes
FROM film;
-- Challenge 1, Exercise 2.1

SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- Challenge 1, Exercise 2.2

SELECT
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- Challenge 1, Exercise 2.3 (Bonus)

SELECT
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday')
            THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;
-- Challenge 1, Exercise 3
-- Display film titles and rental durations

SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
-- Challenge 1, Exercise 4 (Bonus)
-- Prepare customer details for an email campaign

SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;
-- Challenge 2, Exercise 1.1
-- Count the total number of films

SELECT COUNT(*) AS total_films
FROM film;
-- Challenge 2, Exercise 1.2
-- Count the number of films in each rating

SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;
-- Challenge 2, Exercise 1.3
-- Sort ratings by their number of films

SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;
-- Challenge 2, Exercise 2.1
-- Find the average film duration for each rating

SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
-- Challenge 2, Exercise 2.2
-- Find ratings with an average film duration over two hours

SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;
-- Challenge 2, Exercise 3 (Bonus)
-- Find actor last names that appear only once

SELECT
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;