-- CHALLENGE1

-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MAX(LENGTH) AS MAX_DURATION, MIN(LENGTH) AS MIN_DURATION
FROM SAKILA.FILM;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT
    FLOOR(AVG(length) / 60) AS hour,
    FLOOR(AVG(length) % 60) AS minutes
FROM sakila.film;
-- You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT DATEDIFF(MAX(RENTAL_DATE),MIN(RENTAL_DATE)) AS DAYS_OPERATING
FROM SAKILA.RENTAL;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT *,DATE_FORMAT(RENTAL_DATE,'%M') AS RENTAL_MONTH,DATE_FORMAT(RENTAL_DATE,'%W') AS RENTAL_DAY
FROM SAKILA.RENTAL
LIMIT 20;


-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.

SELECT *,
CASE
    WHEN DATE_FORMAT(RENTAL_DATE,'%W') ='Sunday' THEN 'WEEKEND'
    WHEN DATE_FORMAT(RENTAL_DATE,'%W') ='Saturday' THEN 'WEEKEND'
    ELSE 'WORKDAY'
    END AS DAY_TYPE
    FROM SAKILA.RENTAL;
    
-- 3:You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT TITLE,IFNULL(RENTAL_DURATION,'NOT AVAILABLE') AS RENTAL_DURATION
FROM SAKILA.FILM
ORDER BY TITLE;

-- 4: Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need 
-- to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered 
-- by last name in ascending order to make it easier to use the data.

SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS FULL_NAME, LEFT(EMAIL,3) AS EMAIL_STARTING
FROM SAKILA.CUSTOMER
ORDER BY LAST_NAME;

-- CHALLENGE 2
-- 1:Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
       SELECT COUNT(FILM_ID) AS TOTAL_FILMS
       FROM SAKILA.FILM;
    
-- 1.2 The number of films for each rating.

    SELECT RATING,COUNT(*) AS FILM_COUNT
    FROM SAKILA.FILM
    GROUP BY RATING;
       
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
    SELECT RATING,COUNT(*) AS FILM_COUNT
    FROM SAKILA.FILM
    GROUP BY RATING
    ORDER BY FILM_COUNT DESC;
  
  -- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT RATING, ROUND(AVG(LENGTH),2) AS MEAN_DURATION
FROM SAKILA.FILM
GROUP BY RATING
ORDER BY MEAN_DURATION DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT RATING, ROUND(AVG(LENGTH),2) AS MEAN_DURATION
FROM SAKILA.FILM
GROUP BY RATING
HAVING AVG(LENGTH) >120
ORDER BY MEAN_DURATION DESC;

-- 3: Bonus: determine which last names are not repeated in the table actor.
SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;




