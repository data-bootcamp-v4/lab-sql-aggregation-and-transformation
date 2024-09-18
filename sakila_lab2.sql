USE sakila;

-- You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MAX(length) as max_duration FROM sakila.film;
SELECT MIN(length) as min_duration FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    FLOOR(AVG(length) % 60) AS minutes
FROM sakila.film;

-- You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT DATEDIFF(
    (SELECT MAX(rental_date) FROM sakila.rental), 
    (SELECT MIN(rental_date) FROM sakila.rental)
) AS 'Days_Operating';

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT rental_id, rental_date, customer_id, staff_id,
       MONTH(rental_date) AS 'Rental_Month',
       DAYNAME(rental_date) AS 'Rental_Weekday'
FROM sakila.rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.

SELECT rental_id, rental_date, customer_id, staff_id,
       MONTH(rental_date) AS 'Rental_Month',
       DAYNAME(rental_date) AS 'Rental_Weekday',
       CASE
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
           ELSE 'workday'
       END AS 'DAY_TYPE'
FROM sakila.rental
LIMIT 20;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT title AS 'Film_Title',
       IFNULL(rental_duration, 'Not Available') AS 'Rental_Duration'
FROM sakila.film
ORDER BY title ASC;
