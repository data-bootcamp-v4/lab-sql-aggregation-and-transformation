
USE sakila;
-- Challenge 1
-- 1.1 Determine the shortest and longest movie durations and name the values 
-- as max_duration and min_duration.
-- Determining shortest movies durations
SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. 
-- Don't use decimals.
SELECT CONCAT(floor(AVG(length)/60), 'h', ROUND(MOD(floor(AVG(length)),60)), 'min') 
AS average_movie_duration 
FROM sakila.film; 

-- 2.1 Calculate the number of days that the company has been operating
-- first rental date
SELECT DATEDIFF(
	MAX(rental_date),
    MIN(rental_date)) AS days_of_operation
FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show 
-- the month and weekday of the rental. Return 20 rows of results.
SELECT *,  DATE_FORMAT(rental_date, '%M') AS month_rented,
	DAYNAME(rental_date) AS weekday_rented
FROM sakila.rental LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 
-- 'weekend' or 'workday', depending on the day of the week.
SELECT *,  DAYNAME(rental_date) AS weekday_rented, 
CASE
	WHEN DAYNAME(rental_date) IN('Saturday','Sunday') THEN 'weekend'
    ELSE 'workday'
END AS 'DAY_TYPE'
FROM sakila.rental;



-- 3. retrieve the film titles and their rental duration. If any rental duration value is NULL, 
-- replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT title, IFNULL(
	CONCAT(rental_duration,' days'), 'Not Available') AS rental_duration
FROM sakila.film ORDER BY title;


-- Challenge 2
-- 1.1 The total number of films that have been released.
SELECT COUNT(film_id) AS total_films_released FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(film_id) AS number_of_films FROM sakila.film 
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the 
-- number of films. This will help you to better understand the popularity of different film 
-- ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(film_id) AS number_of_films FROM sakila.film 
GROUP BY rating ORDER BY number_of_films DESC;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of 
-- the mean duration. Round off the average lengths to two decimal places. This will help identify 
-- popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2) AS mean_film_duration FROM sakila.film 
GROUP BY rating ORDER BY mean_film_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for 
-- customers who prefer longer movies.
SELECT rating, ROUND(AVG(length),2) AS mean_film_duration FROM sakila.film 
GROUP BY rating
HAVING mean_film_duration>120 ORDER BY mean_film_duration DESC;








    

