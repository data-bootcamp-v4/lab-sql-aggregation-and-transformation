-- Use this 'sakila' Database
USE sakila;
-- Challenge 1
-- 1.Display all available tables in the Sakila database
SHOW TABLES;

-- 1.1 Determine the shortest and longest movie durations and name the values
SELECT 
	MAX(length) AS max_duration,
	MIN(length)  AS min_duration
FROM 
	film;
    
-- 1.2 Express the average movie duration in hours and minutes
SELECT
	FLOOR(AVG(length)/60) AS avg_hours,
    MOD(AVG(length), 60) AS avg_minutes
FROM
	film;

-- 2. Gain insights related to rental dates
-- 2.1 Calculate the number of days that the company has been operating
SELECT
	DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_open
FROM
	rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Limit 20
SELECT
	rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM
	rental
LIMIT 20;

-- 2.3 Retrieve rental information and add an additional column called DAYTYPE with values "weekend" or "workday", depending on the day of the week
 SELECT
	rental_id,
	rental_date,
	MONTHNAME(rental_date) AS rental_month,
	DAYNAME(rental_date) AS rental_weekday,
    CASE
		WHEN DAYNAME(rental_date) IN ("Saturday", "Sunday") THEN "weekend"
        ELSE "workday"
	END AS day_type
    FROM
		rental
	LIMIT 20;

-- 3. Retrieve the film titles and their rental duration. If any NULL, replace "Not Available" Sort the results of the film title in ascending order.
SELECT
	title,
	IFNULL(rental_duration, "Not Available") AS rental_duration
FROM
	film
ORDER BY
	title ASC;

-- 4. Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address. The results should be ordered by last name in ascending order.
SELECT
	CONCAT(last_name,' ',first_name) AS full_name,
    LEFT(email,3) AS three_first_email
FROM
	customer
ORDER BY 
	last_name ASC;

-- Challenge 2
-- 1.Analyze the films in the collection. Using film table, determine:
-- 1.1 The total number of films that have been released
SELECT 
	COUNT(release_year) AS total_number_released_films
FROM
	film;
-- 1.2 The number of films for each rating.
SELECT
	rating,
	COUNT(*) AS number_films_per_rating
FROM
	film
GROUP BY
	rating;
    
-- 1.3 The number of films for each rating, sorting in descending order of the number of films
SELECT
	rating,
	COUNT(*) AS number_films_per_rating
FROM
	film
GROUP BY
	rating
ORDER BY
	number_films_per_rating DESC;

-- 2.Using film table, determine:
-- 2.1 The mean film duration for each rating. Sort the results in descending order of the mean duration.
SELECT
	rating,
	COUNT(*) AS number_films_per_rating,
	CONCAT(
		FLOOR(AVG(length)/60), " hours and ",
		ROUND(MOD(AVG(length), 60),2)," minutes"
	) AS avg_duration
FROM
	film
GROUP BY 
	rating
ORDER BY
	avg_duration DESC;
    
-- 2.2 Identify which ratings have a mean duration of over two hours
SELECT
	rating,
	COUNT(*) AS number_films_per_rating,
	CONCAT(
		FLOOR(AVG(length)/60), " hours and ",
		ROUND(MOD(AVG(length), 60),2)," minutes"
	) AS avg_duration
FROM
	film
GROUP BY 
	rating
HAVING
	AVG(length) > 120
ORDER BY
	avg_duration DESC;
    
-- 3. Determine last names are not repeated in table actor
SELECT
	last_name
FROM
	actor
GROUP BY
	last_name
HAVING
	COUNT(*) = 1;

 

