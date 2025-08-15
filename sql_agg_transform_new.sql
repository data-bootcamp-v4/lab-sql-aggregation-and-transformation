USE sakila;

-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration

SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals

SELECT FLOOR(AVG(length)/60) AS hours,
	   MOD(ROUND(AVG(length)), 60) AS minutes
FROM film;

-- 2.1 Calculate the number of days that the company has been operating

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results

SELECT rental_id, rental_date, inventory_id, customer_id, staff_id,
       MONTH(rental_date) AS rental_month,
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 
-- 'weekend' or 'workday', depending on the day of the week

SELECT rental_id, rental_date, inventory_id, customer_id, staff_id,
       DAYNAME(rental_date) AS rental_weekday,
       CASE 
           WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental
LIMIT 20;

-- retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order

SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Bonus

SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- 1.1 The total number of films that have been released.
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;
-- The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;
-- Bonus: determine which last names are not repeated in the table actor

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;