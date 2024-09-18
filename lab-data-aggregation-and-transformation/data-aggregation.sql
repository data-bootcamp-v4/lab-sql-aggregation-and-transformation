-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    (SELECT MAX(length) FROM film) AS max_duration,
    (SELECT MIN(length) FROM film) AS min_duration;
    
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
-- You need to gain insights related to rental dates:
SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT
    DATEDIFF(
        (SELECT MAX(rental_date) FROM rental),
        (SELECT MIN(rental_date) FROM rental)) AS days_operating;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    -- Extract the month from rental_date
    MONTH(rental_date) AS rental_month,
    -- Extract the weekday name from rental_date
    DAYNAME(rental_date) AS rental_weekday_name
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT
    title AS film_title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, 
-- you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;