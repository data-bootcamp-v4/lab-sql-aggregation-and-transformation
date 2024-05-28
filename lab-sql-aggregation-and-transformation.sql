-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT FLOOR(AVG(length)/60) AS hours, FLOOR(AVG(length)-60) AS minutes FROM film;

-- 2. You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF( (SELECT MAX(rental_date) FROM rental), (SELECT MIN(rental_date) FROM rental)) AS days_operating;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,        
	MONTHNAME(rental_date) AS rental_month, 
	DAYNAME(rental_date) AS rental_weekday  
FROM rental
LIMIT 20;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration FROM film
ORDER BY title ASC;

