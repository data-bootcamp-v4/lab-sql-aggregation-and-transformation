SHOW DATABASES;
USE sakila;
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT * FROM film;
SELECT 
    MAX(length) as max_duration,
    MIN(length) as min_duration
FROM film;
-- 1.2  Express the average movie duration in hours and minutes. Don't use decimals.
SELECT CONCAT(FLOOR(AVG(length)/60), ' hour ', ROUND(MOD(AVG(length), 60), 0), ' minutes') AS AVG_LENGTH
FROM film;
-- MOD(X, Y) = X - (FLOOR(X / Y) * Y)

-- 2.1 Calculate the number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) FROM rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,
        DATE_FORMAT(rental_date, '%M') as month_of_rental,
        DATE_FORMAT(rental_date, '%W') as weekday_of_rental
FROM rental
LIMIT 20;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *, 
    CASE
		WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
	END AS day_type
FROM rental;

-- 3 You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
select title, IFNULL(rental_duration, 'not available')
from film
ORDER BY title;

-- 4 Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT CONCAT(last_name, ' ', first_name) AS name,
		LOWER(SUBSTR(email, 1, 3))
FROM customer
ORDER BY last_name;

-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
-- 1.2 The number of films for each rating.
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

-- 1.1
SELECT COUNT(title) FROM film;
-- 1.2
SELECT rental_rate, COUNT(title)
FROM film
GROUP BY rental_rate;
-- 1.3 
SELECT rental_rate, COUNT(title) AS amount_of_films
FROM film
GROUP BY rental_rate
ORDER BY amount_of_films DESC;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. 
-- This will help identify popular movie lengths for each category.
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.


-- 2.1
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2
SELECT rating, 
		ROUND(AVG(length), 2) AS avg_duration,
        CASE 
			WHEN ROUND(AVG(length), 2) > 120 THEN 'More than 2 hours'
            ELSE 'Less than 2 hours'
		END AS '2_hours'
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 3 Bonus: determine which last names are not repeated in the table actor.
SELECT *
FROM actor
WHERE last_name IN (
    SELECT last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(*) = 1
);