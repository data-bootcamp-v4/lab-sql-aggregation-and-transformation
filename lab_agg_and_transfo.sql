USE sakila;
/*
You need to use SQL built-in functions to gain insights relating to the duration of movies:

1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
1.2. Express the average movie duration in hours and minutes. Don't use decimals.
Hint: Look for floor and round functions.
You need to gain insights related to rental dates:

2.1 Calculate the number of days that the company has been operating.
Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
Hint: use a conditional expression.
You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
Hint: Look for the IFNULL() function.
Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
To achieve this, you need to retrieve the concatenated first and last names of customers, 
along with the first 3 characters of their email address, 
so that you can address them by their first name and use their email address to send personalized recommendations. 
The results should be ordered by last name in ascending order to make it easier to use the data.
*/
-- 1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MIN(length) AS 'Min_duration', 
    MAX(length) AS 'Max_duration', 
    ROUND(AVG(length)) AS 'Average_duration' 
FROM sakila.film;

-- 2 Calculate the number of days that the company has been operating
SELECT 
    MIN(rental_date) AS earliest_rental_date, 
    MAX(rental_date) AS latest_rental_date
FROM sakila.rental;

SELECT 
    DATEDIFF(
        (SELECT MAX(rental_date) FROM sakila.rental), 
        (SELECT MIN(rental_date) FROM sakila.rental)
    ) AS number_of_days_operating;

SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    DATE_FORMAT(rental_date, '%M') AS month,
    DATE_FORMAT(rental_date, '%W') AS weekday
FROM 
    sakila.rental
LIMIT 20;

SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    DATE_FORMAT(rental_date, '%M') AS month,
    DATE_FORMAT(rental_date, '%W') AS weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM 
    sakila.rental
LIMIT 20;

-- 3
SELECT 
    title,
    COALESCE(CONVERT(rental_duration, CHAR), 'Not Available') AS rental_duration
FROM 
    sakila.film
ORDER BY 
    title ASC;



/*
Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
1.1 The total number of films that have been released.
1.2 The number of films for each rating.
1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
Using the film table, determine:
2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
Bonus: determine which last names are not repeated in the table actor.
*/
-- 1.1
SELECT COUNT(*) AS total_number_of_films
FROM sakila.film;
-- 1.2 
SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating;
-- 1.3
SELECT rating, COUNT(*) AS number_of_films
FROM sakila.film
GROUP BY rating
ORDER BY number_of_films DESC;


-- 2.1
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2
SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

