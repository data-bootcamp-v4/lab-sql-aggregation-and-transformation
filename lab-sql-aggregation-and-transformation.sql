USE sakila;

-- ==================================================
-- Challenge 1
-- ==================================================

-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM sakila.film;
-- 1.2 Express the average movie duration in hours and minutes. Don't use decimals.
SELECT CONCAT(FLOOR(AVG(length) / 60), ' hours, ', FLOOR(AVG(length) % 60), ' minutes') AS average_duration
FROM sakila.film;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) FROM sakila.rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_id,rental_date, MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday FROM sakila.rental
LIMIT 20;

-- 3. retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order
SELECT title, IFNULL(rental_duration, "Not Available") FROM sakila.film
ORDER BY title;

-- 4. retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT CONCAT(first_name, ' ', last_name) AS full_name, LEFT(email, 3) AS email_prefix
FROM sakila.customer
ORDER BY last_name;

-- ==================================================
-- Challenge 2
-- ==================================================

-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released
SELECT COUNT(film_id) FROM sakila.film;
-- 1.2 The number of films for each rating
SELECT rating, COUNT(film_id) AS total
FROM sakila.film
GROUP BY rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(film_id) AS total
FROM sakila.film
GROUP BY rating
ORDER BY total DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
 SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;

-- 3. determine which last names are not repeated in the table actor
SELECT last_name
FROM sakila.actor
GROUP BY last_name
Having COUNT(last_name) = 1;



