use sakila;

-- 1.1 Determine the shortest and longest movie durations and name 
-- the values as max_duration and min_duration

SELECT 
	MIN(length) AS 'min_duration',
    MAX(length) AS 'max_duration'
from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
	FLOOR(AVG(length) / 60),
    FLOOR(AVG(length) % 60)
FROM film;

SELECT 
	CONCAT(FLOOR(avg(length)),'h '
	, FLOOR(MOD(avg(length), 60)), 'm') AS 'Average Movie Duration'
from film;

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to  
-- subtract the earliest date in the rental_date column from the latest date.

SELECT datediff( max(rental_date), min(rental_date))
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the 
-- month and weekday of the rental. Return 20 rows of results.%a %b

Select *, MONTHNAME(rental_date) AS month, DAYNAME(rental_date) AS week_day
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called 
-- DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

Select *, MONTHNAME(rental_date) AS month, DAYNAME(rental_date) AS week_day, 
CASE 
WHEN DAYNAME(rental_date) in ('Saturday', 'Sunday') THEN 'weekend' 
ELSE 'workday' END as DAY_TYPE
FROM rental
LIMIT 20;

-- You need to ensure that customers can easily access information about the 
-- movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the 
-- results of the film title in ascending order.

SELECT title, 
CASE
WHEN IsNULL(rental_duration) in (1) then 'not Avaiable' 
ELSE rental_duration
END as rental_duration
FROM film
ORDER BY title ASC;

-- Challenge 2
-- Next, you need to analyze the films in the collection 
-- to gain some more insights. Using the film table, determine:

-- 1.1 The total number of films that have been released.

SELECT cOUNT(release_year) AS number_of_releases
FROM film;

-- 1.2 The number of films for each rating.

SELECT rating, COUNT(*) as num_films
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in 
-- descending order of the number of films. This will help you to better 
-- understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT rating, COUNT(*) as num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

-- 2 Using the film table, determine

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean 
-- duration. Round off the average lengths to two decimal places. This will help identify popular movie 
-- lengths for each category.

SELECT rating, COUNT(*) as num_films, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY num_films DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films 
-- for customers who prefer longer movies.

SELECT rating, COUNT(*) as num_films, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY num_films DESC;
