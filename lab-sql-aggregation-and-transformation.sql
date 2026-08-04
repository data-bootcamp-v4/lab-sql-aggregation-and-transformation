USE sakila;


-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MIN(length) as max_duration, MAX(length) as min_duration
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- SELECT CONCAT(SUBSTRING_INDEX(ROUND((FLOOR(AVG(LENGTH))/60), 2), '.', 2), LEFT(ROUND((FLOOR(AVG(LENGTH))/60), 2),1))
SELECT Concat(CONCAT(FLOOR(AVG(length)/60), ' hour(s) '), CONCAT(FLOOR(AVG(length) - 60), ' minutes ')) as 'AVG film duration'
FROM film;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
SELECT MAX(DATEDIFF(NOW(), rental_date)) as 'number of days'
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, DATE_FORMAT(rental_date, '%M') as Month,
CASE 
    WHEN DATE_FORMAT(rental_date, '%w') = '0' THEN 'Sunday'
    WHEN DATE_FORMAT(rental_date, '%w') = '1' THEN 'Monday'
    WHEN DATE_FORMAT(rental_date, '%w') = '2' THEN 'Tuesday'
	WHEN DATE_FORMAT(rental_date, '%w') = '3' THEN 'Wednesday'
    WHEN DATE_FORMAT(rental_date, '%w') = '4' THEN 'Thursday'
    WHEN DATE_FORMAT(rental_date, '%w') = '5' THEN 'Friday'
    WHEN DATE_FORMAT(rental_date, '%w') = '6' THEN 'Saturday'
    ELSE 'Error data'
END AS 'Weekday'
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *,
CASE 
    WHEN DATE_FORMAT(rental_date, '%w') = '0' THEN 'weekend'
    WHEN DATE_FORMAT(rental_date, '%w') = '1' THEN 'workday'
    WHEN DATE_FORMAT(rental_date, '%w') = '2' THEN 'workday'
	WHEN DATE_FORMAT(rental_date, '%w') = '3' THEN 'workday'
    WHEN DATE_FORMAT(rental_date, '%w') = '4' THEN 'workday'
    WHEN DATE_FORMAT(rental_date, '%w') = '5' THEN 'workday'
    WHEN DATE_FORMAT(rental_date, '%w') = '6' THEN 'weekend'
    ELSE 'Error data'
END AS 'DAY_TYPE'
FROM rental
LIMIT 20;

-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title, IFNULL(rental_duration, "Not Available") as rental_duration
FROM film
ORDER BY title ASC;

-- 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT first_name, last_name, email, CONCAT(CONCAT(UPPER(first_name), UPPER(last_name)), LEFT(UPPER(email),3)) as concat_names
FROM customer
ORDER BY last_name;

-- Challenge 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(film_id)
FROM film
WHERE release_year IS NOT NULL;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(film_id) as 'number of films'
FROM film
WHERE release_year IS NOT NULL
GROUP BY rating

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(film_id) as 'number of films'
FROM film
WHERE release_year IS NOT NULL
GROUP BY rating
ORDER BY COUNT(film_id) DESC; 

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2) as avg_film_duration
FROM film
WHERE release_year IS NOT NULL
GROUP BY rating
ORDER BY avg_film_duration DESC; 

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length),2) as avg_film_duration
FROM film
GROUP BY rating
HAVING avg_film_duration > 120
ORDER BY avg_film_duration DESC;

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name, COUNT(*) as last_name_count
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1
ORDER BY last_name_count; 