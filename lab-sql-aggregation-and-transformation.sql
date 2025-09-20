-- Setting the working database
USE sakila;

-- Display all available tables in the Sakila database.
SHOW TABLES;

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
-- select title, MIN(length) as min_duration from sakila.film group by title order by min_duration asc LIMIT 1;
-- select title,  MAX(length) as max_duration from sakila.film group by title order by min_duration desc LIMIT 1;
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM sakila.film;
   
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select  SEC_TO_TIME(ROUND(AVG(length)) * 60) AS formatted_duration FROM sakila.film;

-- 2.1 Calculate the number of days that the company has been operating
select Max(datediff(last_update,rental_date)) from sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *, DATE_FORMAT(CONVERT(rental_date, DATE), '%W') as weekday, DATE_FORMAT(CONVERT(rental_date, DATE), '%M') as month from sakila.rental limit 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT *,
  CASE
    WHEN UPPER(DATE_FORMAT(CONVERT(rental_date, DATE), '%W')) IN ('SATURDAY', 'SUNDAY') THEN 'weekend'
    -- WHEN UPPER(DATE_FORMAT(CONVERT(rental_date, DATE), '%W')) IN ('MONDAY', 'TUSDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY') THEN 'weekend'
    ELSE 'workday'
  END AS DAY_TYPE
FROM sakila.rental;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

select rental_id, f.title, IFNULL(datediff(return_date, rental_date), 'Not Available') as day_diff
	from sakila.rental as r
JOIN sakila.film as f
	ON r.rental_id = f.film_id
ORDER BY f.title ASC;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', LEFT(email, 3) as email_start FROM sakila.customer;

-- 1.1 The total number of films that have been released.
SELECT count(*) FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT rating, count(*) FROM sakila.film group by rating;

-- .3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, count(*) as films FROM sakila.film group by rating order by films DESC;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2) AS Average FROM sakila.film group by rating order by Average DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length),2) AS Average 
FROM sakila.film 
GROUP BY rating 
HAVING Average > 120
ORDER BY Average DESC;

-- Bonus: determine which last names are not repeated in the table actor.
Select distinct(last_name) as last_name from sakila.actor order by last_name ASC;



