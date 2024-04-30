USE sakila;

#1. Display all available tables in the Sakila database.
SHOW TABLES;

#2. Retrieve all the data from the tables actor, film and customer.
SELECT *
FROM actor;
SELECT *
FROM film;
SELECT *
FROM customer;

#3. Retrieve the following columns from their respective tables:
-- 3.1 Titles of all films from the film table
SELECT title
FROM film;

-- 3.2 List of languages used in films, with the column aliased as language from the language table
SELECT name AS language_type
FROM language;

-- 3.3 List of first names of all employees from the staff table
SELECT first_name
FROM staff;

#4 Retrieve unique release years:
SELECT DISTINCT release_year
FROM film;

#5 Counting records for database insights:
-- 5.1 Determine the number of stores that the company has.
SELECT COUNT(DISTINCT store_id)
FROM store;

-- 5.2 Determine the number of employees that the company has.
SELECT COUNT(DISTINCT staff_id)
FROM staff;

-- 5.3 Determine how many films are available for rent and how many have been rented.
-- how many films are available for rent
SELECT COUNT(film_id)
FROM film;

-- how many have been rented
SELECT COUNT(rental_id)
FROM rental;

-- 5.4 Determine the number of distinct last names of the actors in the database
SELECT COUNT(DISTINCT last_name)
FROM actor;

#6 Retrieve the 10 longest films.
SELECT length
FROM film
ORDER BY length DESC;

#7 Use filtering techniques in order to:
-- 7.1 Retrieve all actors with the first name "SCARLETT".
SELECT * 
FROM actor
WHERE first_name = 'SCARLETT';

#BONUS:
-- 7.2 Retrieve all movies that have ARMAGEDDON in their title and have a duration longer than 100 minutes.
SELECT * 
FROM film
WHERE title LIKE '%ARMAGEDDON%' AND length > 100;

-- 7.3 Determine the number of films that include Behind the Scenes content

SELECT *
FROM film
WHERE special_features LIKE '%Behind the Scenes%';

# Challenge 1 (SQL Data Aggregation and Transformation)
-- You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(rental_duration) AS max_duration
FROM film;
SELECT MIN(rental_duration) AS min_duration
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM 
    film;

#2 You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date), 
MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows 
-- of results.
SELECT *,
    DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', 
-- depending on the day of the week.
SELECT *,
    CASE 
        WHEN DATE_FORMAT(rental_date, '%w') IN (0, 6) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;


#3 Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 
-- 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


#4 Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters
-- of their email address, so that you can address them by their first name and use their email address to send personalized 
-- recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

# Challenge 2 (SQL Data Aggregation and Transformation)
# 1 Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(release_year) AS total_films
FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions 
-- accordingly.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

#2 Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the 
-- average lengths to two decimal places.
SELECT rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer 
-- longer movies.
SELECT rating, 
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120
ORDER BY mean_duration DESC;

#3 Bonus: determine which last names are not repeated in the table actor.

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
