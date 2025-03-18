USE sakila;

-- =======================================
-- CHALLENGE 1
-- =======================================

-- 1. Use SQL built-in functions to gain insights relating to the duration of movies
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM film;

-- 1.2 Express the average movie duration in hours and minutes. Don't use decimals
SELECT 
	FLOOR(AVG(length)/60) AS average_hours, -- if using round it will round it up to the nesxt nearest integer, however we just want to discart the decimal part
    ROUND(AVG(length) % 60) AS average_minutes
FROM film;

-- 2. Rental dates
-- 2.1 Calculate the number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_company_days
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_id, rental_date, customer_id, MONTH(rental_date) AS month, WEEKDAY(rental_date) AS weekday
FROM rental;
-- LIMIT 20;

-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week
SELECT rental_id, rental_date, customer_id, MONTH(rental_date) AS month, WEEKDAY(rental_date) AS weekday, 
	   CASE 
           WHEN  WEEKDAY(rental_date) < 5 THEN 'workday'
           ELSE 'weekend'
       END AS DAY_TYPE
FROM rental;

-- 3. Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order. 
SELECT f.title, IFNULL(CAST(DATEDIFF(r.return_date, r.rental_date) AS CHAR), 'Not Available') AS rental_duration
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY rental_duration ASC;

-- 4. Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- =======================================
-- CHALLENGE 2
-- =======================================
-- 1. Analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT release_year, COUNT(film_id) AS number_films
FROM film
GROUP BY release_year;

-- 1.2 The number of films for each rating
SELECT rating, COUNT(film_id) AS number_films
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(film_id) AS number_films
FROM film
GROUP BY rating
ORDER BY number_films DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length),2) AS average_duration
FROM film
GROUP BY rating
HAVING  ROUND(AVG(length)/60, 1) >= 2
ORDER BY average_duration DESC;

-- 3. Determine which last names are not repeated in the table actor.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;


