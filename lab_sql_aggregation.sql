USE sakila;

-- CHALLENGE 1 (film table)
-- Determine the shortest and longest movie durations and name the values
SELECT 
	MAX(length) as max_duration,
    MIN(length) as min_duration
FROM sakila.film;

-- Express the average movie duration in hours and minutes. Don't use decimals
SELECT
	FLOOR(AVG(length) / 60) as average_duration_hours,		-- FLOOR is to get whole number
    FLOOR(AVG(length) % 60) as average_duration_minutes		-- %60 gets the remaining minutes after converting to hours and rounds down to nearest whole number
FROM sakila.film;

-- Calculate the number of days that company has been operating
SELECT 
	DATEDIFF(MAX(rental_date), MIN(rental_date)) as operating_days
FROM sakila.rental;

-- Retrieve rental info and add two additional columns to show month and weekday of the rental. Return 20 rows results.
SELECT *,
	MONTHNAME(rental_date) as rental_month,
    DAYNAME(rental_date) as rental_day
FROM sakila.rental
LIMIT 20;

-- Another solution
SELECT *, DATE_FORMAT(rental_date, '%M') AS MONTH, DATE_FORMAT(rental_date, '%W') AS WEEKDAY
FROM rental
LIMIT 20;

-- Retrieve rental information and add an additional column Day_Type
SELECT *,
	MONTHNAME(rental_date) as rental_month,
    DAYNAME(rental_date) as rental_day,
	CASE 
		WHEN DAYNAME(rental_date) = 'Monday' THEN 'workday'
		WHEN DAYNAME(rental_date) = 'Tuesday' THEN 'workday'
		WHEN DAYNAME(rental_date) = 'Wednesday' THEN 'workday'
		WHEN DAYNAME(rental_date) = 'Thursday' THEN 'workday'
		WHEN DAYNAME(rental_date) = 'Friday' THEN 'workday'
		WHEN DAYNAME(rental_date) = 'Saturday' THEN 'weekend'
		WHEN DAYNAME(rental_date) = 'Sunday' THEN 'weekend'
	END AS DAY_TYPE
FROM sakila.rental;

-- Another solution
SELECT *, 
	DATE_FORMAT(rental_date, '%M') AS MONTH, 
    DATE_FORMAT(rental_date, '%W') AS WEEKDAY,
	CASE
		WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
		ELSE 'workday'
	END AS DAY_TYPE
FROM sakila.rental;


-- Retrieve film titles and their rental duration
-- For NULL value, replace it with string 'Not Available'
-- Sort result of title in Ascending order

SELECT 
	title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;
    
-- Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address
-- Results should be ordered by last name in ascending order

SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix 				-- to extract the first 3 characters of the email field
FROM sakila.customer
ORDER BY last_name ASC;    


-- CHALLENGE 2 (film table)
-- Determine the total number of films that have been released
SELECT COUNT(title)
FROM sakila.film;

-- Determine the number of films for each rating
SELECT COUNT(*) AS number_of_films, rating
FROM sakila.film
GROUP BY rating;

-- Determine the number of films for each rating, sorting the results in descending order
SELECT COUNT(*) AS number_of_films, rating
FROM sakila.film
GROUP BY rating 
ORDER BY number_of_films DESC;

-- Determine the mean film duration for each rating, sort the result in descending order
-- Round off the average lengths into two decimal places
SELECT 
	rating,
    ROUND(AVG(length),2) AS average_film_duration
FROM sakila.film
GROUP BY rating
ORDER BY average_film_duration DESC;

-- Identify which ratings have a mean duration of over two hours
SELECT 
    rating,
    AVG(length) AS average_film_duration_hours
FROM sakila.film
GROUP BY rating
HAVING average_film_duration_hours > 120;

-- Determine which last names are not repeated in the table actor
SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;

