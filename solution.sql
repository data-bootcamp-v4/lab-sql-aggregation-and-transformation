USE sakila;

-- Challenge 1
-- 1.1 Shortest and longest movie durations
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes (no decimals)
SELECT FLOOR(AVG(length) / 60) AS hours,
       ROUND(AVG(length) % 60) AS minutes
FROM film;

-- 2.1 Number of days the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Rental info with month and weekday (20 rows)
SELECT *, MONTH(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 BONUS: DAY_TYPE column (weekend / workday)
SELECT *,
       CASE
           WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3. Film titles and rental duration ('Not Available' if NULL), ordered by title
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Bonus: full name + first 3 characters of email, ordered by last name
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1 Total number of films
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films for each rating
SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating;

-- 1.3 Same, sorted by number of films (descending)
SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

-- 2.1 Mean film duration for each rating (2 decimals), descending
SELECT rating, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC;

-- 2.2 Ratings with a mean duration of over two hours
SELECT rating, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Bonus: last names that are not repeated in the actor table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
