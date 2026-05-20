USE sakila;
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT * FROM film;
SELECT max(length) AS max_duration, min(length) AS min_duration FROM film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
FLOOR(AVG(length)/60) AS duration_hours,
FLOOR(AVG(length)) AS duration_minutes
FROM film;
-- 2.1 Calculate the number of days that the company has been operating
SELECT * FROM rental;
SELECT datediff(max(rental_date), min(rental_date)) AS Life_time
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results
SELECT *, date_format(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE), '%M') AS month,
	WEEKDAY(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE)) AS day
    FROM rental
    LIMIT 20;

-- 2.3 *Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values
--  'weekend' or 'workday', depending on the day of the week.
SELECT *,
CASE
	WHEN WEEKDAY(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE)) BETWEEN 0 AND 4 THEN 'workday'
    WHEN WEEKDAY(CONVERT(SUBSTRING_INDEX(rental_date, ' ', 1), DATE)) BETWEEN 5 AND 6 THEN 'weekend'
    ELSE 'some_error'
END AS DAY_TYPE
FROM rental;

-- 3. You need to ensure that customers can easily access information about the movie collection.
--  To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'.
-- Sort the results of the film title in ascending order.
SELECT title, rental_duration,
IFNULL(rental_duration, 'Not Available') AS 'availability'
FROM film
ORDER BY title ASC;

-- 4. Bonus: 
SELECT 
	first_name, last_name, email,
	CONCAT(first_name,' ', last_name, ' ', LEFT(email,3)) AS contact_info
FROM customer AS contact
ORDER BY last_name ASC;

-- CHALLENGE 2
-- 1.1 The total number of films that have been released.
SELECT COUNT(release_year) FROM film
WHERE release_year IS NOT NULL;
SELECT * from film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(rating) AS number
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, 
-- sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different
-- film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(rating) AS number
FROM film
GROUP BY rating
ORDER BY number DESC;

 -- 2.1 The mean film duration for each rating, and sort the results
 -- in descending order of the mean duration. Round off the average
 -- lengths to two decimal places. This will help identify popular movie lengths for each category.   
 
 SELECT rating,
 ROUND(AVG(length),2) AS average_duration
 FROM film
 GROUP BY rating
 ORDER BY average_duration DESC;
 
 -- 2.2 Identify which ratings have a mean duration of over
 -- two hours in order to help select films for customers who prefer longer movies.
SELECT rating,
 ROUND(AVG(length),2) AS average_duration
 FROM film 
 GROUP BY rating
 HAVING average_duration > 120
 ORDER BY average_duration DESC;
 
 -- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1
ORDER BY last_name;