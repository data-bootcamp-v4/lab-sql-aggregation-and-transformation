-- CHALLENGE 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
    SELECT MIN(length) AS min_duration, MAX(length) AS max_duration
    FROM film;
	-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions.
	SELECT SEC_TO_TIME(ROUND(AVG(length), 0)*60)
    FROM film;
    
-- 2. You need to gain insights related to rental dates:
	-- 2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
    SELECT DATEDIFF(MAX(rental_date) - MIN(rental_date))
    FROM rental; -- This is not working IDK why
    
    SELECT MAX(rental_date) FROM rental; -- 2006-02-14 15:16:03
    SELECT MIN(rental_date) FROM rental; -- 2005-05-24 22:53:30
    SELECT DATEDIFF("2006-02-14", "2005-05-24")
    FROM rental
    LIMIT 1; -- this one prints a ton of numbers
	
    SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))
    FROM rental; -- okay, I needed a comma
    
	-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
    SELECT *, MONTH(rental_date) AS month, WEEKDAY(rental_date) as weekday -- it is perfect, but I prefer to have the weekday name
    FROM rental
    LIMIT 20;
    
    SELECT *, MONTH(rental_date) AS month, DAYNAME(rental_date) as weekday -- it is perfect, but I prefer to have the weekday name
    FROM rental
    LIMIT 20;
    
	-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.
	SELECT *,
    CASE
		WHEN DAYNAME(rental_date) IN ("Tuesday", "Wednesday", "Thursday", "Friday", "Monday") THEN "workday"
        ELSE "weekend"
	END AS DAY_TYPE
    FROM rental;
-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future. Hint: Look for the IFNULL() function.
SELECT title, IFNULL(rental_duration, "Not Available") AS rental_duration
FROM film
ORDER BY title;

-- CHALLENGE 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
	-- 1.1 The total number of films that have been released.
    SELECT COUNT(DISTINCT title)
    FROM film;
    
	-- 1.2 The number of films for each rating.
    SELECT rating, COUNT(title) as amount
    FROM film
    GROUP BY rating;
    
	-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
	SELECT rating, COUNT(title) as amount
    FROM film
    GROUP BY rating
    ORDER BY amount DESC;
    
-- 2. Using the film table, determine:
	-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
    SELECT rating, ROUND(AVG(length), 2) AS duration
    FROM film
    GROUP BY rating
    ORDER BY duration DESC;
    
    SELECT rating, SEC_TO_TIME(ROUND(AVG(length), 2)*60) AS duration
    FROM film
    GROUP BY rating
    ORDER BY duration DESC; -- this is extra, just to use what I learnt before. It formats time as h:min:sec
    
	-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
    SELECT rating, SEC_TO_TIME(ROUND(AVG(length), 2)*60) AS duration
    FROM film
    GROUP BY rating
    HAVING SEC_TO_TIME(ROUND(AVG(length), 2)*60) > "02:00:00";
    
    SELECT rating, SEC_TO_TIME(ROUND(AVG(length), 2)*60) AS duration
    FROM film
    GROUP BY rating
    HAVING ROUND(AVG(length), 2) > "120";
    
    SELECT rating, SEC_TO_TIME(ROUND(AVG(length), 2)*60) AS duration
    FROM film
    GROUP BY rating
    HAVING duration > "02:00:00";
    
    -- I was doing it wrong because I tried with where. I tried to simplify it in the second block to clarify a little bit. 
    -- but the mistake was that to filer using an aggregation in a clause we need to use HAVING
    -- I'll leave both :))
    -- the third one was an extra attemp just to try :))