USE sakila;
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(sfilm.length) as max_duration, 
		MIN(sfilm.length) as min_duration
FROM sakila.film as sfilm;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT FLOOR(AVG(sfilm.length)/60 ) AS hours,
FLOOR(AVG(sfilm.length)%60) as minutes
FROM sakila.film as sfilm;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(sr.rental_date),MIN(sr.rental_date))
FROM sakila.rental as sr;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT sr.*, 
CASE 
	WHEN DAYOFWEEK(sr.rental_date) IN (1,7) THEN "Weekend"
ELSE "Workday"
END as Day_type
FROM sakila.rental as sr
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT sr.*,
monthname(sr.rental_date) as Month, 
dayname(sr.rental_date) as Day
FROM sakila.rental as sr;
-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
    sf.title, 
    CASE 
        WHEN sf.rental_duration IS NULL THEN 'Not Available'
        ELSE sf.rental_duration
    END AS rental_duration
FROM sakila.film AS sf
ORDER BY sf.title ASC;


-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT CONCAT(scus.first_name," ",scus.last_name) as name, 
		substring(scus.email,1,3) as email_3char
FROM sakila.customer as scus
ORDER BY scus.last_name DESC;


-- 1.Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(sf.release_year)
FROM sakila.film as sf;

-- 1.2 The number of films for each rating.
SELECT sf.rating, COUNT(*) as n_rating 
FROM sakila.film as sf
GROUP BY sf.rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT sf.rating, COUNT(*) as n_rating 
FROM sakila.film as sf
GROUP BY sf.rating
ORDER BY sf.rating DESC;

-- 2.Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT  sf.rating, 
		ROUND(AVG(sf.length),2) as mean_duration 
FROM sakila.film as sf
GROUP BY sf.rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT  sf.rating, 
		ROUND(AVG(sf.length),2) as mean_duration 
FROM sakila.film as sf
GROUP BY sf.rating
HAVING mean_duration>120 -- Uso having porque primero se debe hacer una operación.
ORDER BY mean_duration DESC;

-- Bonus: determine which last names are not repeated in the table actor.
SELECT sa.last_name
FROM sakila.actor as sa
GROUP BY sa.last_name
HAVING COUNT(*)=1;
