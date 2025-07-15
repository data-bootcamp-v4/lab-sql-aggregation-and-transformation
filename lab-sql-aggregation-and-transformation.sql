-- You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM 
	film
GROUP BY release_year;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT 
	ROUND(AVG(length), 0) as avg_duration
FROM
	film;
    
-- You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT 
	DATEDIFF(MAX(rental_date), MIN(rental_date)) as time_in_business
FROM
	rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
	*,
    DAYNAME(rental_date) as weekday,
    MONTH(rental_date) as month
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT
	*,
    DAYNAME(rental_date) as weekday,
    CASE 
		WHEN DAYNAME(rental_date) = "Sunday" OR DAYNAME(rental_date) = "Saturday" THEN "weekend"
		ELSE "workday"
	END AS DAY_TYPE
FROM 
	rental;
    
-- You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration.
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
SELECT 
	title,
    CASE 
		WHEN rental_duration is NULL THEN "Not Available"
        ELSE rental_duration
	END AS new_rental_duration
FROM
	film
ORDER BY title;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, 
-- along with the first 3 characters of their email address, so that you can address them by their first name 
-- and use their email address to send personalized recommendations. The results should be ordered by last name 
-- in ascending order to make it easier to use the data.

SELECT CONCAT(first_name, " ",  last_name , " ", LEFT(email, 3)) AS full_name
FROM customer
ORDER BY last_name ASC;

-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT 
	COUNT(DISTINCT(film_id)) as film_count
FROM 
	film;
    
-- 1.2 The number of films for each rating
SELECT
	rating,
	COUNT(distinct(film_id)) as film_count
FROM
	film
group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
SELECT
	rating,
	COUNT(distinct(film_id)) as film_count
FROM
	film
group by rating
ORDER BY film_count DESC;

-- The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT 
	rating,
	ROUND(AVG(length), 2) as avg_length
FROM 
	film
GROUP BY rating 
ORDER BY avg_length DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT 
	rating,
   	ROUND(AVG(length), 2) as avg_length
FROM 
	film
GROUP BY rating
HAVING avg_length > 120;

-- Bonus: determine which last names are not repeated in the table actor.
SELECT 
	last_name,
    COUNT(last_name) AS last_name_count
FROM 
	actor
GROUP BY last_name
HAVING last_name_count = 1