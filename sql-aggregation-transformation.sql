-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT min(length) AS min_duration, max(length) AS max_duration
FROM sakila.film;

-- Película con la duración más larga
SELECT title, length AS max_duration 
FROM film
ORDER BY length DESC 
LIMIT 1;

-- Película con la duración más corta
SELECT title, length AS min_duration 
FROM film
ORDER BY length ASC 
LIMIT 1;


-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- 		Hint: Look for floor and round functions.
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- 		Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(MAX(r.return_date), MIN(r.rental_date)) AS days_operating
FROM sakila.rental r;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,
	month(rental_date) as month_rental,
    weekday(rental_date) as weekday_rental
FROM sakila.rental r
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- 		Hint: use a conditional expression.
SELECT *,
	weekday(rental_date) as weekday_rental,
    case when weekday(rental_date)>4 then 'weekend'
    else 'workday' 
    end as day_type
FROM sakila.rental r;

-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
-- 		Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- 		Hint: Look for the IFNULL() function.
SELECT f.title, IFNULL(f.rental_duration, 'Not Available') AS rental_duration
FROM sakila.film f;

-- Challenge 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(film_id) as films_released
FROM sakila.film
WHERE release_year IS NOT NULL;

-- 1.2 The number of films for each rating.
SELECT rating, count(film_id) as number_of_films
FROM sakila.film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, count(film_id) as number_of_films
FROM sakila.film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length), 2) as duration
FROM sakila.film
GROUP BY rating
ORDER BY duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) as duration
FROM sakila.film
GROUP BY rating
HAVING duration > 120;

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT DISTINCT(last_name)
FROM sakila.actor;