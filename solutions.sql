USE sakila;
SHOW tables;
SELECT * FROM film;

-- Challenge 1
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;

SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(MOD(AVG(length), 60)) AS minutes
FROM film;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS date_difference FROM rental;

SELECT *, MONTHNAME(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday FROM rental LIMIT 20;

SELECT title, IFNULL(rental_duration, 'Not Available') FROM film ORDER BY title ASC;

-- Challenge 2

SELECT COUNT(*) FROM film;

SELECT rating, COUNT(*) AS number_of_films FROM film GROUP BY rating;


SELECT rating, COUNT(*) AS number_of_films FROM film GROUP BY rating ORDER BY number_of_films DESC;


SELECT * FROM film;

SELECT rating, ROUND(AVG(length),2) AS duration_of_films FROM film GROUP BY rating ORDER BY duration_of_films DESC;

SELECT rating, ROUND(AVG(length),2) AS duration_of_films FROM film GROUP BY rating HAVING(duration_of_films > 120) ORDER BY duration_of_films DESC;


/*
Challenge 1
✅ 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	✅ 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
	✅ 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
		(Hint: Look for floor and round functions.)
✅ 2. You need to gain insights related to rental dates:
	✅ 2.1 Calculate the number of days that the company has been operating.
		(Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.)
	✅ 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
	
✅ 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order. Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
	(Hint: Look for the IFNULL() function.)

Challenge 2
✅ 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
	✅ 1.1 The total number of films that have been released.
	✅ 1.2 The number of films for each rating.
	✅ 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
✅ 2. Using the film table, determine:
	✅ 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
	✅ 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
*/
