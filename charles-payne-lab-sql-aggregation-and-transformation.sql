-- LAB | SQL Data Aggregation and Transformation
USE sakila;

-- 1.1. Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT 
    MIN(length) AS 'min_duration',
    MAX(length) AS 'max_duration'
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT
	FLOOR(AVG(length)/60) AS 'hours',
	ROUND(AVG(length)%60) AS 'minutes'
FROM film;

-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS Datediff
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
-- Return 20 rows of results.

SELECT 
	monthname(rental_date) AS 'month',
    dayname(rental_date) AS 'weekday'
FROM rental
LIMIT 20;

-- 3. Retrieve the film titles and their rental duration.
-- If any rental duration value is NULL, replace it with the string 'Not Available'.
-- Sort the results of the film title in ascending order.

SELECT title, rental_duration 
FROM film;

SELECT IFNULL(rental_duration, "Not Available") AS rental_duration
FROM film;

SELECT title, rental_duration
FROM film
WHERE rental_duration IS NOT NULL
ORDER BY title ASC;

-- CHALLENGE 2
-- 1. Using the film table, determine;
-- 1.1. The total number of films that have been released.
-- 1.2. The number of films for each rating.
-- 1.3. The number of films for each rating, sorting the results in descending order of the number of films.

SELECT COUNT(release_year) FROM film;

SELECT rating, count(rating)
FROM film
GROUP BY rating;

SELECT rating, count(rating)
FROM film
GROUP BY rating
ORDER BY count(rating) DESC;

-- Using the film table, determine:
-- 2.1. The mean film duration for each rating, and 
-- sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, round(avg(length),2) AS 'average length' 
FROM film
GROUP BY rating
ORDER BY round(avg(length),2) DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, round(avg(length),2) AS 'average length' 
FROM film
GROUP BY rating
HAVING round(avg(length),2) > 120;

-- BONUS: determine which last names are not repeated in the table actor.
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name
HAVING count(last_name) <= 1;