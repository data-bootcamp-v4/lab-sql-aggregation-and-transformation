-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;
SELECT length as max_duration
FROM film
ORDER BY length DESC
LIMIT 1;

SELECT length as min_duration
FROM film
ORDER BY length ASC
LIMIT 1;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT FLOOR(AVG(length)/60) as avg_length_hours
FROM film;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT rental_date FROM rental;
SELECT MIN(rental_date) FROM rental;
SELECT MAX(rental_date) FROM rental;
SELECT DATEDIFF('2006-02-14 15:16:03', '2005-05-24 22:53:30') AS days_operating;
# 266
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT * FROM rental;
SELECT *,
       MONTH(rental_date) AS month,
       DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT *,
CASE 
           WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental;

-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Challenge 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(*) FROM film;
-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. 
-- This will help identify popular movie lengths for each category.
SELECT * FROM film;
SELECT rating, ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT * FROM film;
SELECT rating, ROUND(AVG(length),2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;
-- Bonus: determine which last names are not repeated in the table actor
SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;