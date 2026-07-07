Use sakila;
-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
  MAX(length) AS max_duration, 
  MIN(length) AS min_duration 
FROM film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
  FLOOR(AVG(length) / 60) AS hours, 
  FLOOR(AVG(length) % 60) AS minutes 
FROM film;
-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) 
FROM rental;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) 
AS days_operating 
FROM rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
  rental_date, 
  MONTH(rental_date) AS month, 
  DAYNAME(rental_date) AS weekday 
FROM rental 
LIMIT 20;
-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration.
-- If any rental duration value is NULL, replace it with the string 'Not Available'.
-- Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
#Example with CASE
SELECT 
  title, 
  CASE 
    WHEN rental_duration IS NULL THEN 'Not Available'
    ELSE rental_duration
  END AS rental_duration 
FROM film 
ORDER BY title ASC;
#test
SELECT title, rental_duration 
FROM film 
WHERE rental_duration IS NULL;
#EXAMPLE WITH IFNULL()
SELECT 
  title, 
  IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Challenge 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(*) AS total_films
FROM film;
-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;
-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
-- Round off the average lengths to two decimal places. 
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT 
    rating, 
    ROUND(AVG(length), 1) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;