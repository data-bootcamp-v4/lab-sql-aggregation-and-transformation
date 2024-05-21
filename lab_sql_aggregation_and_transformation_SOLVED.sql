USE sakila;

-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

--  Express the average movie duration in hours and minutes. Don't use decimals.

SELECT
    CONCAT(
        FLOOR(AVG(length) / 60), ' hours ',
        MOD(AVG(length), 60), ' minutes'
    ) AS average_duration
FROM film;

--  Calculate the number of days that the company has been operating.

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
-- Return 20 rows of results.

SELECT 
    *,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT 
    *,
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

-- You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. If any rental duration value is
-- NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- The marketing team for the movie rental company now needs to create a personalized email campaign 
-- for customers. To achieve this, you need to retrieve the concatenated first and last names of 
-- customers, along with the first 3 characters of their email address, so that you can address them by 
-- their first name and use their email address to send personalized recommendations. The results should
-- be ordered by last name in ascending order to make it easier to use the data.

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- The total number of films that have been released.

SELECT COUNT(*)
FROM film;

-- The number of films for each rating.

SELECT rating, COUNT(*) AS "number of movies"
FROM film
GROUP BY rating;

-- The number of films for each rating, sorting the results in descending order of the number of films.

SELECT rating, COUNT(*) AS "number of movies"
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

-- The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. 
-- This will help identify popular movie lengths for each category.

SELECT rating, round(AVG(length),2) AS average_length
FROM film
GROUP BY rating
ORDER BY average_length DESC;

-- Identify which ratings have a mean duration of over two hours in order to help select 
-- films for customers who prefer longer movies.

SELECT rating, round(AVG(length),2) AS average_length
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_length DESC;

-- Bonus: determine which last names are not repeated in the table actor

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
