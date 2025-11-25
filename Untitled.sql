
USE sakila;


/* 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration. */
SELECT title, length
FROM (
    SELECT title, length
    FROM film
    ORDER BY length DESC, title
    LIMIT 1
) AS max_duration
UNION ALL
SELECT title, length
FROM (
    SELECT title, length
    FROM film
    ORDER BY length ASC, title
    LIMIT 1
) AS min_duration;

/* 1.2. Express the average movie duration in hours and minutes. Don't use decimals. */
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    FLOOR(AVG(length) % 60) AS minutes
FROM film;

/* 2. Using the film table, determine 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.*/
SELECT
	datediff(MAX(rental_date),MIN(rental_date)) as Days_Operating
FROM rental;

/* 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.*/

SELECT
	monthname(rental_date) AS 'rental_month',
    dayname(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

/* 3. Bonus: determine which last names are not repeated in the table actor.*/
SELECT 
    last_name,
    COUNT(*) AS number_last_names
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;