-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

--     1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;

SELECT MAX(length) AS max_duration, 
       MIN(length) AS min_duration FROM sakila.film;

--     1.2. Express the average movie duration in hours and minutes. Don't use decimals.

SELECT ROUND(AVG(length)) FROM sakila.film;

-- You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
--     Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date 
--           in the rental_date column from the latest date.

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM sakila.rental;

# DATEDIFF (end_date,start_date) returns the number of days between those two dates.

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
-- Return 20 rows of results.

SELECT rental_id, rental_date, customer_id, MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_day
FROM sakila.rental
LIMIT 20;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 
--    'weekend' or 'workday', depending on the day of the week.                                                   
--     Hint: use a conditional expression.

SELECT rental_id, rental_date, customer_id, MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_day,
IF (DAYOFWEEK(rental_date) IN (1, 7), 'weekend', 'workday') AS day_type
FROM sakila.rental
LIMIT 20;

-- 3. You need to ensure that customers can easily access information about the movie collection.
-- To achieve this, retrieve the film titles and their rental duration.
--  If any rental duration value is NULL, replace it with the string 'Not Available'.                                                                           
-- Sort the results of the film title in ascending order.

SELECT title, rental_duration, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

#WITH THE CONDITION WE CREATE A NEW COLUMN THAT WE NAME IT AGAIN rental_duration

-- 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email
-- campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, 
-- along with the first 3 characters of their email address, so that you can address them by their first name 
-- and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.
