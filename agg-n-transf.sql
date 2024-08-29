USE sakila;
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MIN(length) AS min_duration, 
    MAX(length) AS max_duration
FROM sakila.film;
-- 1.2  Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM sakila.film;

-- Show output as one table
SELECT 
    MAX(length) AS max_duration_minutes,
    MIN(length) AS min_duration_minutes,
    ROUND(AVG(length)) AS avg_duration_minutes 
FROM sakila.film;

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
-- retrieve rental information from  rental_id, rental_date, customer_id, inventory_id, return_date, staff_id 
SELECT rental_id, rental_date, customer_id, inventory_id, return_date, staff_id,
MONTHNAME(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM sakila.rental LIMIT 20;

-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT rental_id, rental_date, customer_id, inventory_id, return_date, staff_id,
DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM sakila.rental
LIMIT 20;

-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order. 
SELECT title, ISNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

-- CHALLENGE 2
-- 1.1 The total number of films that have been released.
SELECT COUNT(*) AS total_films FROM sakila.film;
-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.
SELECT rating, 
       ROUND(AVG(length), 2) AS average_duration
FROM sakila.film
GROUP BY rating
ORDER BY average_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, 
       ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_duration DESC;