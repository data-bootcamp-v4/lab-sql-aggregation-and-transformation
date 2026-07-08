USE sakila;

### CHALLENGE 1 

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) max_duration, MIN(length) min_duration FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions. 
SELECT FLOOR (length/60) FROM film; -- hours column 
SELECT MOD(length,60) FROM film; -- minutes column 

SELECT CONCAT(FLOOR (length/60), ",", MOD(length,60)) as hours_and_minutes FROM film; 

# You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT * FROM rental; 
SELECT MIN(rental_date) as earliest FROM rental; -- 2005-05-24 22:53:30 The first rental 
SELECT MAX(rental_date) as latest FROM rental; -- 2005-09-02 02:35:22 The last rental transaction date 

SELECT DATEDIFF((MAX(rental_date)), (MIN(rental_date)))
FROM rental;  # Answer = 266 days 

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, DATE_FORMAT(rental_date, "%M") as return_month, DATE_FORMAT(rental_date, "%W") as return_weekday FROM rental; 

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.

SELECT *, 
CASE
	WHEN WEEKDAY(rental_date) IN (5, 6) THEN "Weekend"
    ELSE "Workday"
END as day_type
FROM rental; 

-- Retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
# Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
# Hint: Look for the IFNULL() function. 

SELECT SUM(ISNULL(rental_duration)) FROM sakila.film; 
SELECT title, rental_duration FROM film; 

--  Replace nulls 
SELECT *, CASE   
WHEN rental_duration is null then "Not Available"
ELSE rental_duration END as rental_duration
FROM sakila.film
ORDER BY title ASC; 

SELECT title, IFNULL(rental_duration, "Not Available") as rental_duration
FROM sakila.film
ORDER BY title ASC; 

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT email FROM customer;

SELECT CONCAT(first_name, last_name) as customer_name, 
LEFT(email, 3) as email_prefix
FROM customer
ORDER BY last_name ASC;


### CHALLENGE 2 
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT * FROM film; 

SELECT COUNT(DISTINCT title) FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(title) as number_of_films 
FROM sakila.film
GROUP BY rating; 

-- OR 
SELECT rating,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;


-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. 
-- This will help identify popular movie lengths for each category.
SELECT * FROM film; 

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC; 

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, (AVG(length)/60)
FROM sakila.film
GROUP BY rating 
HAVING (AVG(length)/60) > 2;  # WHERE does not allow aggregations while HAVING yes. WHERE (AVG(length)/60) > 2 doesn't work. 

-- Bonus: determine which last names are not repeated in the table actor
SELECT * FROM actor; 

SELECT last_name, COUNT(last_name) # or just COUNT(*) because GROUP BY happens before SELECT COUNT, so COUNT counts the number of rows in each group 
FROM actor 
GROUP BY last_name
HAVING COUNT(last_name) = 1; 
