USE sakila;
-- -- Challenge 2:
-- 1.1 Determine the shortest and longest movie durations 
-- and name the values as max_duration and min_duration.
SELECT  
	   MAX(length) AS max_duration,
	   MIN(length) AS min_duration 
FROM film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT max_duration,
	   min_duration,
       ROUND((max_duration + min_duration) / 2, 0) AS avg_duration
FROM (
		SELECT  
	   MAX(length) AS max_duration,
	   MIN(length) AS min_duration 
FROM film
) AS sub;
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT  
	   MAX(rental_date) AS earliest_date,
	   MIN(rental_date) AS latest_date 
FROM rental;

SELECT 
	  DATEDIFF(
       MAX(rental_date),
	   MIN(rental_date)
       ) AS days_between
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT
	  DATE (rental_date) AS Rental_date_only,
      MONTH (rental_date) AS Month_number,
      MONTHNAME (rental_date) AS month_name,
      DAYNAME (rental_date) AS weekday_name

 FROM rental LIMIT 20;
	

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT
	  DATE (rental_date) AS Rental_date_only,
      MONTH (rental_date) AS Month_number,
      MONTHNAME (rental_date) AS month_name,
      DAYNAME (rental_date) AS weekday_name,
CASE 
    WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
    ELSE 'workday'
END AS day_type
 FROM rental LIMIT 20;
-- 3.You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
	  title, 
      rental_duration,
CASE
	WHEN rental_duration IS NULL THEN 'Not Available'
    ELSE "Available"
    END AS availability
 FROM film;
     
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

-- Challenge 2: Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT * FROM film;

SELECT  
	COUNT(film_id) as number_of_films
	FROM film;
    

-- 1.2 The number of films for each rating.
SELECT  
	rating, 
    COUNT(film_id) as number_of_films
	FROM film
	GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT  
	rating, 
    COUNT(film_id) as number_of_films
	FROM film
	GROUP BY rating
    ORDER BY number_of_films DESC;


-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT  
	rating, 
    ROUND(AVG(length),2) as average_length
	FROM film
	GROUP BY rating 
    ORDER BY average_length DESC;
    

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT  
	rating, 
    ROUND(AVG(length),2) as average_length
	FROM film
	GROUP BY rating 
    HAVING AVG(length)>120
    ORDER BY average_length DESC;