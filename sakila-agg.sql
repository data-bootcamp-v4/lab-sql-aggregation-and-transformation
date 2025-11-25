			-- CHALLENGE 1

-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM sakila.film;

	-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.

SELECT
  FLOOR(ROUND(AVG(length)) / 60) AS avg_hours,
  MOD(ROUND(AVG(length)), 60)         AS avg_minutes,
  CONCAT(
    FLOOR(ROUND(AVG(length)) / 60), ' h ',
    MOD(ROUND(AVG(length)), 60), ' min'
  ) AS avg_duration_hm
FROM sakila.film;

-- 2. You need to gain insights related to rental dates:
	-- 2.1 Calculate the number of days that the company has been operating.

SELECT
	DATEDIFF(MAX(rental_date),MIN(rental_date)) AS operating_days
FROM sakila.rental;

	-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date)   AS rental_weekday
FROM sakila.rental
LIMIT 20;

	-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM sakila.rental;

-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration.
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT
    title,
    IFNULL(length, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

-- 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers.

SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM sakila.customer
ORDER BY last_name ASC;
			
						-- CHALLENGE 2
			
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
	-- 1.1 The total number of films that have been released.
			
SELECT COUNT(*) AS total_films_released
FROM sakila.film
WHERE release_year IS NOT NULL;

	-- 1.2 The number of films for each rating.
			
SELECT
    rating,
    COUNT(*) AS film_count
FROM sakila.film
GROUP BY rating;

	-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
	-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
			
SELECT
    rating,
    COUNT(*) AS film_count
FROM sakila.film
GROUP BY rating
ORDER BY film_count DESC;
			
-- 2. Using the film table, determine:
	-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
	-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
			
SELECT
    rating,
    ROUND(AVG(length),2) AS avg_length
FROM sakila.film
GROUP BY rating
ORDER BY avg_length DESC;

	-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT
    rating,
    ROUND(AVG(length), 2) AS avg_length
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY avg_length DESC;

-- 3. Bonus: determine which last names are not repeated in the table actor.

SELECT
    last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC;
