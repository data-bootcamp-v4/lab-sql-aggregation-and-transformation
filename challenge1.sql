--1 You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS 'max_duration', MIN(length) AS 'min_duration'
FROM film


-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions.

SELECT CONCAT( floor(AVG(length)/60), ':', MOD(round(AVG(length)), 60))
FROM film

--ALT PEOR
SELECT CONCAT( floor(AVG(length)/60), ':', round(AVG(length)%60))
FROM film

-- 2 You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT datediff(MAX(rental_date), MIN(rental_date)) AS 'date_diff'
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

-- Weekday goes from 0 to 6
SELECT *, month(rental_date) as 'month', weekday(rental_date) as 'weekday'
FROM rental
LIMIT 20;

--ALT peor
SELECT *, DATE_FORMAT(rental_date, '%m') AS 'month', DATE_FORMAT(rental_date, '%d') AS 'weekday'
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.

SELECT *, CASE
	WHEN DAYNAME(rental_date) IN ('Saturday','Sunday') THEN 'Weekend'
	ELSE 'Workday'
END AS 'DAY_TYPE'
FROM rental
LIMIT 20

--3 Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT title, IFNULL(rental_duration, 'Not Available') AS 'Rental duration'
FROM film
ORDER BY title ASC

--ALT PEOR
SELECT title, CASE
	WHEN rental_duration IS NULL THEN 'Not Available'
	ELSE rental_duration
END AS 'Rental duration'
FROM film
-- ORDER BY title ASC NOT NECESSARY IN THIS CASE

--4 Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address

SELECT concat(first_name, last_name,SUBSTRING(email, 1, 3)) as concat_data
FROM customer
ORDER BY last_name ASC

--ALT
SELECT concat(first_name, last_name,LEFT(email, 3)) as concat_data
FROM customer
ORDER BY last_name ASC


















