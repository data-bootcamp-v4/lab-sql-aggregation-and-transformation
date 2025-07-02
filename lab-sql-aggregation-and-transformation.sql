USE sakila;

-- Challenge
-- 1
Use sakila;

-- 1.1 Determine the shortest and longest movie durations (max_duration and min_duration)
SELECT MAX(length) as 'max_duration', MIN(length) as 'min_duration' FROM sakila.film;
-- 1.2 Express the average movie duration in hours and minutes, without decimals
SELECT ROUND(AVG(length)) FROM sakila.film;

-- 2
-- 2.1 Calculate the number of days the company has been operating
SELECT rental_date FROM sakila.rental;

-- 2.2 Retrieve rental info with month and weekday (20 rows)
SELECT *, DATE_FORMAT(CONVERT(rental_date, DATE), '%M') as 'Month',DATE_FORMAT(CONVERT(rental_date, DATE), '%D') as 'Day' FROM sakila.rental limit  20;

-- 3 Retrieve film titles and rental duration, replacing NULLs with 'Not Available', ordered by title
SELECT title, rental_duration FROM sakila.film WHERE ISNULL(rental_duration) = "Not Available" ;


-- Cahellenge
-- 1
-- 1.1 The **total number of films** that have been released.
SELECT COUNT(*) from sakila.film;
-- 1.2 The **number of films for each rating**
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 The **number of films for each rating, sorting** the results in descending order of the number of films.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;


-- 2
-- 2.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

-- 2.2  Identify **which ratings have a mean duration of over two hours** in order to help select films for customers who prefer longer movies.
--  *Bonus: determine which last names are not repeated in the table `actor`.*
SELECT rating, ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_duration DESC;
