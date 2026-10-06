USE sakila;

/* You need to use SQL built-in functions to gain insights relating to the duration of movies:
1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
1.2. Express the average movie duration in hours and minutes. Don't use decimals.
Hint: Look for floor and round functions. */

SELECT 
    MAX(length) AS max_duration
FROM
    film;
    
SELECT 
    MIN(length) AS min_duration
FROM
    film;
    
SELECT 
    ROUND(AVG(length)) AS avg_duration
FROM
    film;

/* You need to gain insights related to rental dates:
2.1 Calculate the number of days that the company has been operating.
Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
Hint: use a conditional expression. */

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS company_days
FROM
    rental;


SELECT 
    rental_id,
    inventory_id,
    customer_id,
    rental_date,
    DATE_FORMAT(CONVERT( rental_date , DATE), '%M') AS month,
    DATE_FORMAT(CONVERT( rental_date , DATE), '%W') AS weekday
FROM
    rental
LIMIT 20;

SELECT 
    rental_id,
    inventory_id,
    customer_id,
    rental_date,
    DATE_FORMAT(CONVERT( rental_date , DATE), '%W') AS weekday,
    CASE
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday' , 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM
    rental;

/* You need to ensure that customers can easily access information about the movie collection.
To achieve this, retrieve the film titles and their rental duration. 
If any rental duration value is NULL, replace it with the string 'Not Available'. 
Sort the results of the film title in ascending order.
Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
Hint: Look for the IFNULL() function. */

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM
    film
ORDER BY title;

/* Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email
address, so that you can address them by their first name and use their email address to send personalized recommendations. 
The results should be ordered by last name in ascending order to make it easier to use the data.*/

SELECT 
    *
FROM
    customer;
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_3_characters
FROM
    customer
ORDER BY last_name;


/* Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
1.1 The total number of films that have been released.
1.2 The number of films for each rating.
1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly. */

SELECT 
    rating, COUNT(title) AS total_films
FROM
    film
GROUP BY rating
ORDER BY total_films DESC;

/*Using the film table, determine:
2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.*/

SELECT 
    rating, ROUND(AVG(length), 2) AS avg_duration
FROM
    film
GROUP BY rating
ORDER BY avg_duration DESC;

SELECT 
    rating, ROUND(AVG(length), 2) AS avg_duration
FROM
    film
GROUP BY rating
HAVING AVG(length) > 120;

-- Bonus: determine which last names are not repeated in the table actor.
SELECT 
    last_name AS only_once
FROM
    actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;
