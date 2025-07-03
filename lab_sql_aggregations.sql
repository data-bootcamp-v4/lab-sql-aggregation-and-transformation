USE sakila;

-- Challenge 1
-- You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) as max_duration FROM sakila.film;
SELECT MIN(length) as min_duration FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT 
    FLOOR(AVG(length) / 60) AS avg_duration_hrs,
    ROUND(AVG(length) % 60) AS avg_duration_mins
FROM sakila.film;

-- You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(max(rental_date), min(rental_date)) from sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select rental_date from sakila.rental;


SELECT *, DATE_FORMAT(CONVERT(rental_date,DATE), '%M') AS rentaly_month, DAYNAME(rental_date) FROM sakila.rental
Limit 20;


-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT *,
CASE 
    WHEN DAYNAME(rental_date) in ('Saturday', 'Sunday') THEN 'weekend'
    ELSE 'workday'
END AS DAY_TYPE
FROM sakila.rental;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT title,
CASE 
    WHEN rental_duration IS NULL THEN 'Not Available'
    ELSE rental_duration
END as rental_duration
FROM sakila.film
order by title;


-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, 
-- along with the first 3 characters of their email address, so that you can address them by their first name and use their email address
--  to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT LEFT(email,3), CONCAT(first_name, last_name) AS 'customer' FROM sakila.customer
Order by last_name;

-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(film_id) from sakila.film;

-- 1.2 The number of films for each rating.
SELECT rating, count(film_id) AS 'number_of_films' 
FROM sakila.film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, count(film_id) AS 'number_of_films' 
FROM sakila.film
GROUP BY rating
order by number_of_films desc;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, count(film_id) AS 'number_of_films', round(AVG(length),2) AS 'average_length'
FROM sakila.film
GROUP BY rating
order by average_length desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, title, round(AVG(length),2) AS 'average_length'
FROM sakila.film
GROUP BY rating, title
HAVING average_length > 120;

-- Bonus: determine which last names are not repeated in the table actor.