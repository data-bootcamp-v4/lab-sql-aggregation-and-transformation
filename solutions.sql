USE sakila;

-- Challenge 1
-- 1.1 Shortest and longest movie durations
SELECT
MIN(length) AS shortest_movie_duration,
MAX(length) AS longest_movie_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes
SELECT
FLOOR(AVG(length)/60) AS hours, -- FLOOR ROUNDS DOWN
ROUND(AVG(length)%60) AS minutes -- % WHATS LEFT FROM PREVIOUS TRANSACTION
FROM film;

-- 2.1 Number of days the company has been operating
SELECT
DATEDIFF(MAX(rental_date),MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Rental info with month and weekday
SELECT *,
MONTH(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM rental;

-- 2.3 BONUS: Weekend or workday
SELECT *,
CASE
WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend' -- 1 is Sunday, 7 Saturday
ELSE 'workday'
END AS day_type
FROM rental;

-- 3. Film titles and rental duration, handling NULL values
SELECT title,
IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. BONUS: Customer full names and first 3 email characters
SELECT
CONCAT(first_name, ' ', last_name) AS full_name,
SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- Challenge 2
-- 1.1 Total number of films released
SELECT COUNT(*) AS total_films_released
FROM film;

-- 1.2 Number of films for each rating
SELECT rating,
COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating, descending
SELECT rating,
COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Mean film duration for each rating
SELECT rating,
ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with mean duration over two hours
SELECT rating,
ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- BONUS: Last names that are not repeated in actor table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
