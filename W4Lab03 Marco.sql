-- Week04 Lab03
-- Lab | SQL Data Aggregation and Transformation
USE sakila;

-- CHALLENGE 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length), MIN(length) FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. 
SELECT FLOOR(AVG(length)) FROM sakila.film;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
SELECT 
	MIN(rental_date) AS date1, 
    MAX(return_date) AS date2, 
    DATEDIFF(MAX(return_date), MIN(rental_date)) AS days_difference 
FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
	*, 
    DAYNAME(rental_date),
    MONTHNAME(rental_date)
-- 	DATE_FORMAT(CONVERT(rental_date, date), '%D') AS day, 
--  DATE_FORMAT(CONVERT(rental_date, date), '%M') AS month 
FROM sakila.rental;


-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
SELECT title,
CASE
	WHEN rental_duration IS NULL THEN 'Not Available'
    ELSE rental_duration
END AS duration
FROM sakila.film;

-- CHALLENGE 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(DISTINCT(title)) FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT rating,COUNT(rating) AS count FROM sakila.film GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating,COUNT(rating) AS count FROM sakila.film
GROUP BY rating
ORDER BY count DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2) as mean_duration FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length),2) as mean_duration FROM sakila.film
GROUP BY rating
HAVING ROUND(AVG(length),2) >= 120;