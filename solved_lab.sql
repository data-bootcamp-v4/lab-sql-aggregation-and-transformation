-- Challenge 1
-- 1.1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
(SELECT sfi.title, sfi.length AS max_duration
FROM sakila.film as sfi
ORDER BY sfi.length ASC LIMIT 1)
UNION
(SELECT sfi.title, sfi.length AS min_duration
FROM sakila.film as sfi
ORDER BY sfi.length DESC LIMIT 1);

-- 1.1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT 
    FLOOR(AVG(sfi.length) / 60) AS avg_hours,  -- Calculate the integer part of hours
    FLOOR(AVG(sfi.length) % 60) AS avg_minutes -- Calculate the remainder for minutes
FROM 
    sakila.film AS sfi;
    
-- 1.2. You need to gain insights related to rental dates:
-- 1.2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT 
    DATEDIFF(MAX(sre.rental_date), MIN(sre.rental_date)) AS days_operating
FROM 
    sakila.rental AS sre;

-- 1.2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental.
-- Return 20 rows of results.
SELECT 
    sre.rental_id,
    sre.rental_date,
    sre.customer_id,
    sre.inventory_id,
    sre.return_date,
    sre.staff_id,
    MONTH(sre.rental_date) AS rental_month,   -- Extract the month from rental_date
    DAYNAME(sre.rental_date) AS rental_weekday -- Extract the weekday name from rental_date
FROM 
    sakila.rental AS sre
LIMIT 20;

-- 1.2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT 
    sre.rental_id,
    sre.rental_date,
    sre.customer_id,
    sre.inventory_id,
    sre.return_date,
    sre.staff_id,
    DAYNAME(sre.rental_date) AS rental_weekday, -- Extract weekday name
    CASE
        WHEN DAYOFWEEK(sre.rental_date) IN (1, 7) THEN 'weekend' -- 1 is Sunday, 7 is Saturday
        ELSE 'workday'
    END AS day_type -- Categorize as weekend or workday
FROM 
    sakila.rental AS sre
LIMIT 20;

-- 1.3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    sakila.film
ORDER BY 
    title ASC;

-- 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    LEFT(email, 3) AS email_preview
FROM 
    sakila.customer
ORDER BY 
    last_name ASC;
    
-- Challenge 2
-- 2.1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
SELECT 
    COUNT(*) AS total_films_released
FROM 
    sakila.film;

-- 2.1.2 The number of films for each rating.
SELECT 
    sfi.rating, 
    COUNT(*) AS films_count
FROM 
    sakila.film AS sfi
GROUP BY 
    sfi.rating;

-- 2.1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT 
    sfi.rating, 
    COUNT(*) AS films_count
FROM 
    sakila.film AS sfi
GROUP BY 
    sfi.rating
ORDER BY 
    films_count DESC;

-- 2.2. Using the film table, determine:
-- 2.2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT 
    sfi.rating, 
    ROUND(AVG(sfi.length), 2) AS mean_duration
FROM 
    sakila.film AS sfi
GROUP BY 
    sfi.rating
ORDER BY 
    mean_duration DESC;

-- 2.2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT 
    sfi.rating, 
    ROUND(AVG(sfi.length), 2) AS mean_duration
FROM 
    sakila.film AS sfi
GROUP BY 
    sfi.rating
HAVING 
    AVG(sfi.length) > 120
ORDER BY 
    mean_duration DESC;

-- 2.3 Bonus: determine which last names are not repeated in the table actor.
SELECT 
    sfa.last_name
FROM 
    sakila.actor AS sfa
GROUP BY 
    sfa.last_name
HAVING 
    COUNT(sfa.last_name) = 1;
