-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT max(length) AS max_duration, min(length) AS min_duration
FROM film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT FLOOR(AVG(length)/60) AS 'Hours', ROUND(AVG(length)%60) AS 'Minutes'
from film;

-- You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
SELECT datediff(MAX(rental_date),MIN(rental_date))
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_date AS 'Rental Date', 
	MONTH(rental_date) AS 'Month of Rental', DAYOFWEEK(rental_date) AS 'Day of Rental'
	FROM rental;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT rental_date AS 'Rental Date', 
	MONTH(rental_date) AS 'Month of Rental',
    DAYOFWEEK(rental_date) AS 'Day of Rental',
CASE
    WHEN rental_date in (1,7) THEN 'WEEKEND'
	ELSE 'WEEKDAY'
END AS 'DAY_TYPE'
FROM rental;

-- You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.


SELECT title as 'FILM', rental_duration AS 'Rental Duration',
CASE
	WHEN rental_duration = NULL THEN 'Not Available'
    ELSE 'Available'
END AS 'AVAILABILITY'
FROM film
ORDER BY title asc;


-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT count(title) 
FROM film;


-- 1.2 The number of films for each rating.
SELECT 'Rated G' AS 'Rating', count(title) AS 'Count' 
FROM film
WHERE rating = 'G'
UNION
SELECT 'Rated PG' AS 'Rating', count(title) AS 'Count' 
FROM film
WHERE rating = 'PG'
UNION
SELECT 'Rated PG-13' AS 'Rating', count(title) AS 'Count' 
FROM film
WHERE rating = 'PG-13'
UNION
SELECT 'Rated NC-17' AS 'Rating', count(title) AS 'Count' 
FROM film
WHERE rating = 'NC-17';

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
SELECT 'Rated G' AS 'Rating', count(title) AS 'Count' 
FROM film
WHERE rating = 'G'
UNION
SELECT 'Rated PG' AS 'Rating', count(title) AS 'Count' 
FROM film
WHERE rating = 'PG'
UNION
SELECT 'Rated PG-13' AS 'Rating', count(title) AS 'Count' 
FROM film
WHERE rating = 'PG-13'
UNION
SELECT 'Rated NC-17' AS 'Rating', count(title) AS 'Count' 
FROM film
WHERE rating = 'NC-17'
ORDER BY Count desc;

# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
# Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT 'Rated G' AS 'Rating', ROUND(AVG(length),2) AS 'Average_Length'
FROM film
WHERE rating = 'G'
UNION 
SELECT 'Rated PG' AS 'Rating', ROUND(AVG(length),2) AS 'Average_Length'
FROM film
WHERE rating = 'PG'
UNION 
SELECT 'Rated PG-13' AS 'Rating', ROUND(AVG(length),2) AS 'Average_Length'
FROM film
WHERE rating = 'PG-13'
UNION 
SELECT 'Rated R' AS 'Rating', ROUND(AVG(length),2) AS 'Average_Length'
FROM film
WHERE rating = 'R'
UNION
SELECT 'Rated NC-17' AS 'Rating', ROUND(AVG(length),2) AS 'Average_Length'
FROM film
WHERE rating = 'NC-17'
ORDER BY Average_Length desc;

# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT 'Rated G' AS 'Rating', ROUND(AVG(length),2)/60 AS 'Average_Length'
FROM film
WHERE rating = 'G'
UNION 
SELECT 'Rated PG' AS 'Rating', ROUND(AVG(length),2)/60 AS 'Average_Length'
FROM film
WHERE rating = 'PG'
UNION 
SELECT 'Rated PG-13' AS 'Rating', ROUND(AVG(length),2)/60 AS 'Average_Length'
FROM film
WHERE rating = 'PG-13'
UNION 
SELECT 'Rated R' AS 'Rating', ROUND(AVG(length),2)/60 AS 'Average_Length'
FROM film
WHERE rating = 'R'
UNION
SELECT 'Rated NC-17' AS 'Rating', ROUND(AVG(length),2)/60 AS 'Average_Length'
FROM film
WHERE rating = 'NC-17'
ORDER BY Average_Length desc;

# Bonus: determine which last names are not repeated in the table actor.
SELECT CONCAT(first_name,' ',last_name) AS 'Actor Name'
FROM actor
WHERE last_name IN (
    SELECT last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(*) = 1);