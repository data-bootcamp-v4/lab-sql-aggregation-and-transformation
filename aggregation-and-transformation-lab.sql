USE sakila;

-- You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT min(length) as shortest_duration, max(length) as longest_duration FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT concat(floor(avg(length) / 60), 'hr',  round(avg(length) % 60,0), 'min') as mean_duration FROM sakila.film;

-- You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(max(rental_date), min(rental_date)) FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, DATE_FORMAT(CONVERT(rental_date, datetime), '%M') AS month, DATE_FORMAT(CONVERT(rental_date, datetime), '%W') AS weekday FROM sakila.rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT *,
CASE 
    WHEN DATE_FORMAT(CONVERT(rental_date, datetime), '%w') = 0 THEN 'weekend'
    WHEN DATE_FORMAT(CONVERT(rental_date, datetime), '%w') = 6 THEN 'weekend'
    ELSE 'workday'
END AS DAY_TYPE FROM sakila.rental;

-- You need to ensure that customers can easily access information about the movie collection.
-- To achieve this, retrieve the film titles and their rental duration.
-- If any rental duration value is NULL, replace it with the string 'Not Available'.
-- Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT title,
IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers.
-- To achieve this, you need to retrieve the concatenated first and last names of customers, 
-- along with the first 3 characters of their email address, so that you can address them by their first name 
-- and use their email address to send personalized recommendations.
-- The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT concat(first_name, " ", last_name) as full_name,
left(email,3) as email_3_char
FROM sakila.customer
ORDER BY last_name;


-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(film_id)
FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(film_id) as number_of_films
FROM sakila.film
group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(film_id) as number_of_films
FROM sakila.film
group by rating
order by COUNT(film_id) DESC;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, round(avg(length),2) as mean_duration
FROM sakila.film
group by rating
order by mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, mean_duration FROM
(SELECT rating, round(avg(length),2) as mean_duration
FROM sakila.film
group by rating) as r
WHERE mean_duration > 120
order by mean_duration DESC;

-- Bonus: determine which last names are not repeated in the table actor.
SELECT last_name FROM
(SELECT last_name, COUNT(actor_id) as name_count FROM sakila.actor
GROUP BY last_name) as n
WHERE name_count = 1;
