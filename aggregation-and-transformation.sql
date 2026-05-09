use sakila;

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select 
max(rental_duration) AS "max_duration", min(rental_duration) AS "min_duration"
FROM film; 

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions.
SELECT 
FLOOR(AVG(length)/60) AS average_hours, 
ROUND(AVG(length)%60) AS average_minutes 
FROM film;


-- 2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS active_days 
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
  select *,
  month(rental_date) as "month",
  weekday(rental_date) as "weekday" 
  from rental limit 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 
-- 'weekend' or 'workday', depending on the day of the week.Hint: use a conditional expression.



-- 3. You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

SELECT 
    CASE 
        WHEN title IS NULL THEN 'not available'
        ELSE title
        
    END AS title, 
    CASE 
        WHEN rental_duration IS NULL THEN 'not available'
        ELSE rental_duration
    END AS rental_duration
FROM film
ORDER BY title ASC; 


-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine
-- 1.1 The total number of films that have been released.
select count(release_year) from film;

-- 1.2 The number of films for each rating.
select  rating, count(title) as "no._of_films"
from film
group by rating
order by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select  rating, count(title) as "no. of films"
from film
group by rating
order by count(title) desc;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select  rating, round(avg(length),2) as "avg_duration"
from film
group by rating
order by avg(length) desc;


-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select  rating, round((avg(length)/60),2) as "avg_duration"
from film
group by rating
order by avg(length) desc;

-- 3. Bonus: determine which last names are not repeated in the table actor.
select last_name , count(last_name) as "count"
from actor
group by last_name
having count(last_name) = "1" 







