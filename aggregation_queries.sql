-- LAB | SQL Data Aggregation and Transformation
-- Challenge 1: Insights into Movie Duration and Rental Dates

USE sakila;

-- 1. Movie Duration Insights
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT 
	MAX(LENGTH) AS max_duration,
    MIN(LENGTH) AS min_duration
FROM
	film;
    
-- 1.2 Express the average movie duration in hours and minutes. Don't use decimals.

SELECT 
    FLOOR(AVG(LENGTH) / 60) AS avg_hours,
    ROUND(AVG(LENGTH) % 60) AS avg_minutes
FROM
    film;
    
-- 2. Rental Date Insights
-- 2.1 Calculate the number of days that the company has been operating.

SELECT 
	DATEDIFF(
		MAX(rental_date),
        MIN(rental_date)
	) AS operating_days
FROM
	rental;
    
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT *,
	DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM
	rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT *,
	CASE 
		WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
	END AS DAY_TYPE
FROM
	rental
LIMIT 20;

-- 3. Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'.

SELECT
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration_status
FROM
    film
ORDER BY
    title ASC;
    
-- 4. Bonus: Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address.

SELECT
    CONCAT(first_name, ' ', last_name) AS full_name, 
    SUBSTRING(email, 1, 3) AS email_prefix          
FROM
    customer
ORDER BY
    last_name ASC;
    
    
-- Challenge 2: Film Collection Analysis   

-- 1. Film Count and Rating Analysis
-- 1.1 The total number of films that have been released.

SELECT 
	COUNT(film_id) AS total_films
FROM
	film;
    
-- 1.2 The number of films for each rating.

SELECT
	rating,
    COUNT(film_id) AS number_of_films
FROM
	film
GROUP BY
	rating;
    
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.

SELECT 
	rating,
    COUNT(film_id) AS number_of_films
FROM
	film
GROUP BY
	rating
ORDER BY
	number_of_films DESC;
    
-- 2. Film Duration Analysis
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.

SELECT
	rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM
	film
GROUP BY
	rating
ORDER BY
	mean_duration DESC;
    
-- 2.2 Identify which ratings have a mean duration of over two hours (120 minutes).

SELECT
	rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM
	film
GROUP BY
	rating
HAVING
	AVG(length) > 120
ORDER BY
	mean_duration DESC;
    
-- 3. Bonus: determine which last names are not repeated in the table actor.

SELECT
	last_name
FROM
	actor
GROUP BY
	last_name
HAVING 
	COUNT(last_name) = 1
ORDER BY
	last_name ASC;
    
