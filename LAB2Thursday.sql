-- CHALLENGE 1 --

use sakila

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT 
    title, length AS max_duration
FROM
    film
ORDER BY length DESC
LIMIT 1;

SELECT 
    title, length AS min_duration
FROM
    film
ORDER BY length asc
LIMIT 1;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.


SELECT 
    CONCAT(
        FLOOR(AVG(length) / 60), 'hours',
        FLOOR(AVG(length) - FLOOR(AVG(length) / 60) * 60), 'mins'
    ) AS average_movie_duration
FROM 
    film;

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT 
    MAX(rental_date) AS last_date,
    MIN(rental_date) AS first_date
FROM
    rental;
    
SELECT 
    DATEDIFF(days, '2006/02/14', '2005/05/24') AS company_lifetime
FROM
    rental;
    
    
SELECT 
    TIMESTAMPDIFF(month, '2006/02/14', '2005/05/24') AS company_lifetime
FROM
    rental
LIMIT
	1;
    
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT 
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

-- 3 You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT 
    title,
    rental_duration,
    CASE
        WHEN rental_duration IS NULL THEN 'Not Available'
        ELSE 'Available'
    END AS rental_availability
FROM
    film;
    
-- CHALENGE 2 --

-- 1.1 The total number of films that have been released.

SELECT DISTINCT
    COUNT(title)
FROM
    FILM;

-- 1.2 The number of films for each rating.

SELECT DISTINCT
    rating
FROM
    film; 
    

SELECT 
    rating, COUNT(*) AS number_of_films
FROM
    film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.


SELECT 
    rating, COUNT(*) AS number_of_films
FROM
    film
GROUP BY rating
ORDER BY number_of_films DESC;


-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT 
    rating, ROUND(AVG(length), 2) AS avg_film_duration
FROM
    film
GROUP BY rating
ORDER BY avg_film_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT 
    rating, ROUND(AVG(length), 2) AS avg_film_duration
FROM
    film
GROUP BY rating
HAVING avg_film_duration > 120
ORDER BY avg_film_duration DESC;
    