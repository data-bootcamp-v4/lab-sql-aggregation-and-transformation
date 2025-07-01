-- You need to use SQL built-in functions to gain insights relating to the duration of movies:





-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT  max(length) as max_duration, min(length) as min_duration  FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes FROM film;

-- You need to gain insights related to rental dates:



-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS active_days FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, DATE_FORMAT(rental_date, '%M') AS MONTH, DATE_FORMAT(rental_date, '%W') AS WEEKDAY FROM rental LIMIT 20;
 
 -- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration.
 -- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT title, ifnull(rental_duration, 'Not Available')
 FROM film
 order by title ASC;
 
 -- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers.
 -- To achieve this, you need to retrieve the concatenated first and last names of customers,
 -- along with the first 3 characters of their email address,
 -- so that you can address them by their first name and use their email address to send personalized recommendations.
 -- The results should be ordered by last name in ascending order to make it easier to use the data.
 

 
 -- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
-- 1.2 The number of films for each rating.
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT count(film_id) FROM film;

SELECT rating, count(title) as number_per_rating FROM film
group by rating;

SELECT rating, count(title) as number_per_rating FROM film
group by rating 
order by number_per_rating desc;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating, round(AVG(length), 2) as avg_duration from film
group by rating 
order by avg_duration desc;

SELECT rating, round(AVG(length), 2) as avg_duration from film
group by rating 
having avg_duration > 120
order by avg_duration desc;

-- Bonus: determine which last names are not repeated in the table actor.
SELECT last_name,count(last_name) as count1 FROM actor
group by last_name
having count(*) = 1
order by count1 desc
