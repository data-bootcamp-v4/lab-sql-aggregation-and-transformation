-- CHALLENGE 1
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;
SELECT MAX(length) as max_duration FROM film;
SELECT MIN(length) as min_duration FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
	AVG(length) as avg_length,
    FLOOR(AVG(length) / 60) AS avg_length_hours,
    ROUND(MOD(AVG(length), 60)) AS avg_length_minutes
FROM film;

/*
2.1 Calculate the number of days that the company has been operating.
Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
*/
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) as operating_days 
FROM rental; 
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *,
MONTHNAME(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

/*
2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
Hint: use a conditional expression.
*/
SELECT 
	*,
CASE 
	WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
	ELSE 'workday' 
    END AS DAY_TYPE
FROM 
    rental;

/*
3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
Hint: Look for the IFNULL() function.
*/
SELECT 
	title, 
    IFNULL(rental_duration, 'Not Available') as rental_duration
FROM film
ORDER BY title ASC;

/*
4. Retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address.
The results should be ordered by last name in ascending order to make it easier to use the data.
*/
SELECT
	CONCAT(first_name, ' ', last_name) as full_name,
    SUBSTRING(email, 1, 3) as email_prefix
FROM
	customer
ORDER BY last_name ASC;

/*
CHALLENGE 2
Using the film table, determine:
1.1 The total number of films that have been released.
*/
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(rating) as total_films
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
SELECT rating, COUNT(rating) as total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

/*
Using the film table, determine:
2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
Round off the average lengths to two decimal places.
*/
SELECT rating, ROUND(AVG(length), 2) as mean_duration 
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length), 2) as mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name, COUNT(last_name) as count
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;