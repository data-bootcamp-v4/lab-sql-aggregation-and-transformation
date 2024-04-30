-- Challenge 1
-- 1.0 You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT FLOOR(AVG(rental_duration) / 60) AS Average_Hours, AVG(rental_duration) % 60 AS Average_Minutes FROM film;

-- 2.0 You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
SELECT MIN(rental_date) AS start_date, MAX(rental_date) AS end_date, DATEDIFF(MAX(rental_date), MIN(rental_date)) AS date_difference FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, DATE_FORMAT(rental_date, '%M') AS Month, DATE_FORMAT(rental_date, '%W') AS Weekday FROM rental LIMIT 20;

-- Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

-- 3.0 You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
 SELECT title AS Film_Title, IFNULL(rental_duration, 'Not Available') AS Rental_Duration FROM film ORDER BY title ASC;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

-- Challenge 2
-- 1.0 Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(release_year) AS total_number_of_films_released FROM film WHERE release_year IS NOT NULL; 

-- 1.2 The number of films for each rating.
SELECT  rating, COUNT(title) AS total_number_of_films FROM film GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT  rating, COUNT(title) AS total_number_of_films FROM film GROUP BY rating ORDER BY total_number_of_films DESC;

-- 2.0 Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2) AS average_length_of_films FROM film GROUP BY rating ORDER BY average_length_of_films DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT  rating, ROUND(AVG(length) / 60) as Average_Hours FROM film GROUP BY rating having Average_Hours >= 2;
-- Bonus: determine which last names are not repeated in the table actor.