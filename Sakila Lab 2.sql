use sakila;

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT
	max(length) as 'Max Length',
	min(length) as 'Min Length'
from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

SELECT CONCAT(FLOOR(avg(length) / 60), 'Hour', FLOOR(avg(length) % 60), 'Minute') AS 'Average Movie Duration'
FROM film;

-- 2.1 Calculate the number of days that the company has been operating.

select datediff(max(rental_date), min(rental_date)) from rental;

-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select
    rental_id,
    rental_date,
    DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM 
    rental
LIMIT 20;

-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT IFNULL(title, 'N/A') AS 'Title',
IFNULL(rental_duration, 'N/A') AS 'Rental Duration'
FROM film
ORDER BY title ASC;

-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

-- Challenge 2

-- 1.1 The total number of films that have been released.

select count(release_year) as 'Total Released Films' from film;

-- 1.2 The number of films for each rating.

SELECT rating,
sum(CASE 
    WHEN rating = 'PG' THEN 1
    WHEN rating = 'G' THEN 1
    WHEN rating = 'NC-17' THEN 1
    WHEN rating = 'R' then 1
    ELSE 1
END) AS 'Number of Films per Rating'
FROM film
Group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT 
    rating,
    COUNT(title) AS 'Number of Films per Rating'
FROM film
GROUP BY rating
ORDER BY COUNT(title) DESC;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT 
	rating,
		round(avg(length)) AS 'Average Duration'
	FROM film
	GROUP BY rating
	ORDER BY avg(length) DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT 
    rating,
    CASE
        WHEN AVG(length) > 120 THEN 'Above 2 Hours'
        ELSE 'Below or Equal to 2 Hours'
    END AS 'Average Duration'
FROM film
GROUP BY rating;

