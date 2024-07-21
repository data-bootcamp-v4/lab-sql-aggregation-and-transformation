use sakila;
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT title, length AS max_duration
FROM film
WHERE length = (SELECT MAX(length)FROM film);

SELECT title, length AS min_duration
FROM film
WHERE length = (SELECT MIN(length)FROM film);
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT round(AVG(length)/60, 2) AS average_length_in_hours
FROM film;
-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) AS DAYS_OPERATING
FROM rental;
--  Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,
MONTH(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM 
    rental
LIMIT 20;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY
title ASC;
-- The total number of films that have been released.
SELECT COUNT(film_id) AS total_number_of_films
FROM film;
-- The number of films for each rating.
SELECT COUNT(film_id) AS total_number_of_films, rating
FROM film
GROUP BY rating;
-- The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT COUNT(film_id) AS total_number_of_films, rating
FROM film
GROUP BY rating
ORDER BY
COUNT(film_id) DESC;
-- The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating,round(AVG(length), 2) AS mean_film_duration_for_each_rating
FROM film
GROUP BY rating;
-- Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating,round(AVG(length), 2) AS mean_film_duration_for_each_rating
FROM film
GROUP BY rating
HAVING AVG(length) > 120;
-- Bonus: determine which last names are not repeated in the table actor.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

