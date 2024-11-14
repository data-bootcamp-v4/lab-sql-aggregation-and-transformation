USE sakila;
--  shortest and longest movie durations 
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- average movie duration in hours and minutes
SELECT 
	FLOOR(AVG(length)/60) AS average_hour,
    ROUND(AVG(length)%60) AS average_minutes
FROM film;

-- number of days that the company has been operating
SELECT
DATEDIFF(MAX(rental_date),MIN(rental_date)) AS days_operating
FROM rental;

--  month and weekday of the rental
SELECT 
*,
MONTHNAME(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_day
FROM rental;

-- 
SELECT 
*,
MONTHNAME(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_day,
CASE
	WHEN DAYOFWEEK(rental_date) IN (1,7) THEN "Weekend"
    ELSE "Workday"
END AS day_type
FROM rental
LIMIT 20;

-- retrieve the film titles and their rental duration. 

SELECT
	title,
    IFNULL(rental_duration, "Not Available") AS rental_duration
FROM FILM
ORDER BY rental_duration ASC;

-- concatenated first and last names of customers, along with the first 3 characters of their email 

SELECT * FROM customer;
SELECT 
	concat(first_name," ", last_name) AS full_name,
    substring(email, 1, 3) AS email
FROM customer
ORDER BY last_name ASC;

-- total number of films that have been released
SELECT 
count(*)
FROM film;

-- number of films for each rating
SELECT
count(title),
rating
FROM film
GROUP BY rating;

--  number of films for each rating, sorting the results in descending order of the number of films
SELECT
count(title) as amount_of_films,
rating
FROM film
GROUP BY rating
ORDER BY amount_of_films DESC;

-- mean film duration for each rating
SELECT
rating,
ROUND(AVG(length),2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- which ratings have a mean duration of over two hours
SELECT rating 
FROM film 
GROUP BY rating 
HAVING AVG(length) > 120;

-- determine which last names are not repeated in the table actor
SELECT
last_name
from actor
GROUP BY 
    last_name 
HAVING 
    COUNT(*) = 1;

