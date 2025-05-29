-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration
SELECT MAX(length) as max_duration, MIN(length) as min_duration
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. 
SELECT CAST(AVG(length) / 60 AS INT) as hours, CAST(((AVG(length)/60) - CAST(AVG(length) / 60 AS INT)) * 60 AS INT) as minutes
FROM film;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- There is no DATEDIFF in SQLite so I'll transform the dates to JulianDay and subtstract them
SELECT (JulianDay(MAX(rental_date)) - JulianDay(MIN(rental_date))) AS rent_days  FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
---Return 20 rows of results.
SELECT *, strftime('%m', date(rental_date)) as month, strftime('%w', date(rental_date)) as week_day  FROM rental Limit 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *, strftime('%w', date(rental_date)),
	(CASE 
		WHEN strftime('%w', date(rental_date)) = 0 OR strftime('%w', date(rental_date)) = 6 THEN 'weekend'
		ELSE 'workday'
	END) as DAY_TYPE
FROM rental Limit 20;

-- You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
SELECT title, IFNULL(rental_duration, 'Not Available') as rental_duration FROM film;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT concat(first_name, ' ', last_name) as `customer`, substr(email,0, 4) as email
FROM customer
ORDER BY last_name ASC;


-- Challenge 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(film_id)  FROM film
WHERE release_year IS NOT NULL AND release_year <= (SELECT strftime('%Y', MAX(date(f.last_update))) FROM film as f);

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(CASE WHEN rating = rating THEN 1 END) as num_ratings
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(CASE WHEN rating = rating THEN 1 END) as num_ratings
FROM film
GROUP BY rating
ORDER BY num_ratings DESC;

-- 2. Using the film table, determine: 
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(CASE WHEN rating = rating THEN length END), 2) as mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(CASE WHEN rating = rating THEN length END), 2) as mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 2*60
ORDER BY mean_duration DESC;

-- 3. Bonus: determine which last names are not repeated in the table actor
SELECT DISTINCT last_name FROM actor;

