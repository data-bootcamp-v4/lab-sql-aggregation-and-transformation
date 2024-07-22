-- Challenge 1
-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select MAX(rental_duration) as max_duration, MIN(rental_duration) as min_duration
FROM film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT
FLOOR(AVG(length) / 60) AS Hours,
ROUND(AVG(length) % 60) AS Minutes
FROM film;

-- You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(
	(MAX(rental_date) FROM rental)
    (MIN(rental_date) FROM rental)
    AS active_days FROM rental;
    
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, date_format(rental_date, '%M') AS MONTH, DATE_FORMAT(rental_date, '%W') AS WEEKDAY
FROM rental
LIMIT 20;


-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT *, CASE WHEN DATE_FORMAT (rental_date, '%W') in ('Saturday', 'Sunday')
THEN 'weekend'
ELSE 'workday' END AS day_type
FROM rental;

-- 3. Retrieve the film titles and their rental duration
SELECT title, IFNULL(rental_duration, 'Not Available') as rental_duration
FROM film
ORDER BY title ASC;




