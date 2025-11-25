-- CHALLENGE 1

/* 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
1.2. Express the average movie duration in hours and minutes. Don't use decimals.
Hint: Look for floor and round functions.*/

USE sakila;

SELECT title, length
FROM (
    SELECT title, length
    FROM film
    ORDER BY length DESC, title
    LIMIT 1
) AS max_duration
UNION ALL
SELECT title, length
FROM (
    SELECT title, length
    FROM film
    ORDER BY length ASC, title
    LIMIT 1
) AS min_duration;


SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    FLOOR(AVG(length) % 60) AS minutes
FROM film;

/* 2.You need to gain insights related to rental dates:
2.1 Calculate the number of days that the company has been operating.
Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
Hint: use a conditional expression.*/

SELECT
	datediff(MAX(rental_date),MIN(rental_date)) as Days_Operating
FROM rental;

SELECT
	monthname(rental_date) AS 'rental_month',
    dayname(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT rental_date,
    CASE WHEN WEEKDAY(rental_date) IN (5, 6) THEN 'Weekend' ELSE 'Workday' END AS DAY_TYPE
FROM rental;


/* 3.You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
Hint: Look for the IFNULL() function.*/

SELECT 
	title,
    ifnull(rental_duration,'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

/*  4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. 
The results should be ordered by last name in ascending order to make it easier to use the data.*/

SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- CHALLENGE 2

/* 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
1.1 The total number of films that have been released.
1.2 The number of films for each rating.
1.3 The number of films for each rating, sorting the results in descending order of the number of films.
This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.*/

SELECT
	count(release_year) as Films_released
FROM film;

SELECT
	rating,
	count(release_year) as Films_released
FROM film
GROUP BY rating;


SELECT
	rating,
	count(release_year) as Films_released
FROM film
GROUP BY rating
ORDER BY Films_released desc;


/* 2. Using the film table, determine:
2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.*/

SELECT
	rating,
	round(avg(length),2) as avg_length_rounded
FROM film
GROUP BY rating
ORDER BY avg_length_rounded desc;

SELECT
	rating,
	round(avg(length),2) as avg_length_rounded
FROM film
GROUP BY rating
HAVING avg_length_rounded > 120
ORDER BY avg_length_rounded desc;


-- 3. Bonus: determine which last names are not repeated in the table actor.

SELECT 
    last_name,
    COUNT(*) AS number_last_names
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

