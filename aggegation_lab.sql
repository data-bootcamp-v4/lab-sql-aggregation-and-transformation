-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT title, max(length) as max_duration, min(length) as min_duration from film;

SELECT 
    (SELECT MAX(length) FROM film) AS max_duration,
    (SELECT MIN(length) FROM film) AS min_duration;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
   SELECT 
    FLOOR(AVG(length) / 60) AS average_hours,
    ROUND(AVG(length),0) % 60 AS average_minutes
FROM 
    film;
-- Hint: Look for floor and round functions.
-- You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM 
    rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, MONTH(rental_date), WEEKDAY(rental_date) FROM rental 
LIMIT 20;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *,
    rental_date,
    MONTH(rental_date) AS month,
    DAYOFWEEK(rental_date) AS weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM 
  rental;
-- Hint: use a conditional expression.
-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
    IFNULL(rental_duration, 'Not Available') AS rental_duration,
    title 
FROM 
    film;

-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT concat(first_name,last_name) as concat_name, SUBSTRING(email, 1,3) as email_characters from customer
ORDER BY last_name ASC;


-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(film_id) from film;
-- 1.2 The number of films for each rating.
SELECT COUNT(film_id), rating from film
GROUP by rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT COUNT(film_id) as film_count, rating from film
GROUP by rating
ORDER BY film_count DESC;
-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT COUNT(film_id) as film_count, rating, ROUND(AVG(length),2) as mean_duration from film
GROUP by rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT COUNT(film_id) as film_count, rating, ROUND(AVG(length),2) as mean_duration from film
GROUP by rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;
-- Bonus: determine which last names are not repeated in the table actor.
