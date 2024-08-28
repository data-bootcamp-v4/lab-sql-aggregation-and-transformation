-- Challenge 1
USE sakila;

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions.
SELECT FLOOR((AVG(length))/60), ROUND((AVG(length))%60,0), CONCAT(FLOOR((AVG(length))/60)," hour and ",ROUND((AVG(length))%60,0)," minutes") AS average_duration FROM sakila.film;

-- 2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) AS operating_days FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ',1),DATE),'%M') AS rental_month, DATE_FORMAT(CONVERT(SUBSTRING_INDEX(rental_date, ' ',1),DATE),'%D') AS rental_day FROM sakila.rental LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.
SELECT *,
CASE WHEN DAYNAME(CONVERT(SUBSTRING_INDEX(rental_date, ' ',1),DATE)) IN ('Monday','Tuesday','Wednesday','Thursday','Friday') THEN 'workday'
	WHEN DAYNAME(CONVERT(SUBSTRING_INDEX(rental_date, ' ',1),DATE)) IN('Saturday','Sunday') THEN 'weekday'
    ELSE 'unknown'
    END AS 'DAY_TYPE' FROM sakila.rental LIMIT 20;
    
-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT f.title, f.rental_duration,
CASE WHEN ISNULL(f.rental_duration) THEN 'Not Available'
	ELSE f.rental_duration
    END AS 'rental duration' FROM sakila.film AS f
ORDER BY f.title ASC;

-- 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT CONCAT(c.first_name," ", c.last_name) AS full_name, LEFT(c.email,3) FROM sakila.customer AS c
ORDER BY c.last_name ASC;


-- Challenge 2

-- 1.1 The total number of films that have been released.
SELECT COUNT(film_id) FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(film_id) FROM sakila.film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(film_id) FROM sakila.film
GROUP BY rating
ORDER BY count(film_id) DESC;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, COUNT(length), ROUND(AVG(length),2) FROM sakila.film
GROUP BY rating
ORDER BY AVG(length) DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, COUNT(length), ROUND(AVG(length),2) FROM sakila.film
GROUP BY rating
HAVING ROUND(AVG(length),2)>120
ORDER BY AVG(length) DESC;

-- Bonus: determine which last names are not repeated in the table actor.
SELECT last_name, COUNT(last_name) FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;

