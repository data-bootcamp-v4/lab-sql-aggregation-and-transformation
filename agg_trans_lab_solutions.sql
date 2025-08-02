use sakila;
SELECT * FROM sakila.actor;
-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM 
    film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    CONCAT(
        FLOOR(AVG(length) / 60), ' hours ',
        FLOOR(AVG(length) % 60), ' minutes'
    ) AS avg_duration
FROM 
    film;
-- 2.1 Calculate the number of days that the company has been operating.
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM 
    rental;
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    DATE_FORMAT(rental_date, '%b') AS rental_month,  -- Short month (e.g., 'Jan')
    DATE_FORMAT(rental_date, '%a') AS rental_weekday -- Short weekday (e.g., 'Mon')
FROM 
    rental
LIMIT 20;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday,
    CASE 
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM 
    rental
LIMIT 20;
-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
    title AS film_title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM 
    film
ORDER BY 
    title ASC;
    
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT 
    COUNT(*) AS total_films_released
FROM 
    film;
-- 1.2 The number of films for each rating.
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    number_of_films DESC;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
SELECT 
    COUNT(*) AS total_films,
    SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS G,
    SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS PG,
    SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) AS 'PG-13',
    SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS R,
    SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS 'NC-17'
FROM 
    film;
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration_minutes
FROM 
    film
GROUP BY 
    rating
ORDER BY 
    mean_duration_minutes DESC;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration_minutes
FROM 
    film
GROUP BY 
    rating
HAVING 
    AVG(length) > 120
ORDER BY 
    mean_duration_minutes DESC;
-- determine which last names are not repeated in the table actor.
SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1
ORDER BY 
    last_name;