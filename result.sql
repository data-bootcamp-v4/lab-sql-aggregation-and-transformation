USE sakila;

-- Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.
SELECT MAX(length) as max_duration from film;
SELECT MIN(length) as min_duration from film;

--  Express the **average movie duration in hours and minutes**. Don't use decimals.
SELECT FLOOR(AVG(length)) as average_duration from film;

-- Calculate the **number of days that the company has been operating**.
SELECT datediff(MAX(rental_date), MIN(rental_date)) from rental;

-- Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
SELECT *, 
DATE_FORMAT(rental_date, '%M') as rental_month,
DATE_FORMAT(rental_date, '%W') as rental_weekday
FROM rental
LIMIT 20;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the **film titles and their rental duration**. If any rental duration value is **NULL, replace** it with the string **'Not Available'**. Sort the results of the film title in ascending order.
SELECT title,     
IFNULL(rental_duration, 'Not Available') AS rental_duration
from film 
ORDER BY title ASC;


SELECT COUNT(*) as total_films from film;

SELECT distinct(rating) as ratingssss from film;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;