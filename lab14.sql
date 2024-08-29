-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

SELECT 
    MAX(ROUND(length /60 , 0)) AS max_length
FROM
    sakila.film;
    
SELECT 
    MIN(ROUND(length /60, 0)) AS min_length
FROM
    sakila.film;
    
-- You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) as operating_time
FROM
    sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.

SELECT
	*,
    DATENAME(WEEKDAY, rental_date) as weekday,
    DATENAME(MONTH, rental_date) as month
FROM
    sakila.rental
    SHOW MAX 10;
    
-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT
	*,
	IFNULL(rental_duration, 'Not Available') AS not_available
FROM sakila.film
ORDER BY rental_duration ASC;

-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
-- 1.2 The number of films for each rating.
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT 
    *, COUNT(title) AS total_films
FROM
    sakila.film
GROUP BY rating
ORDER BY rating desc;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.


-- for each rating find the mean duration, sort results in descending order. Round duration in 2 decimals
--  group by rating, aggregate mean over these groups, sort2 in descending order

SELECT 
    round(AVG(length),2) as average_length,
    rating
FROM
    sakila.film
GROUP BY rating
ORDER BY average_length desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT 
    round(AVG(length),2) as average_length,
    rating
FROM
    sakila.film
GROUP BY rating
HAVING average_length > 120;

