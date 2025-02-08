## SQL LAB 2 DAY 2##
USE SAKILA;
-- 1) You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select max(length) as maximum_duration, min(length) as minimum_duration
from film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select  SEC_TO_TIME(FLOOR(ROUND(avg(length),2))) as average_time from film;
-- Hint: Look for floor and round functions.

-- You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select DATEDIFF(CURDATE(), min(rental_date)) as days
from rental ;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select rental_id, rental_date ,monthname(rental_date)as month, dayname(rental_date) as day from rental;
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', 
-- depending on the day of the week.
-- Hint: use a conditional expression.
select  rental_id ,
CASE
   WHEN (dayname(rental_date)='Saturday' OR  dayname(rental_date)='Sunday') THEN 'WEEKEND'
    ELSE 'workday' END 
as DAY_TYPE from rental;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, 
-- retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'.
--  Sort the results of the film title in ascending order.
select title , IFNULL(rental_duration, 'NOT AVAILABLE') AS rental_duration
from film
order by title;


-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, 
-- you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address,
-- so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.
select CONCAT (first_name , last_name,LEFT(email,3)) as customer_name 
from customer
order by last_name asc;


-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(distinct film_id) as total_films_released 
from film;
-- 1.2 The number of films for each rating.
select count(distinct film_id) as total_films ,rating as total_films_released 
from film
group by rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select count(distinct film_id) as total_films ,rating as total_films_released 
from film
group by rating
order by total_films desc;
-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration.
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select SEC_TO_TIME(FLOOR(ROUND(avg(length),2))) as average_duration ,rating
from film
group by rating
order by average_duration desc;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select SEC_TO_TIME(FLOOR(ROUND(avg(length),2))) as average_duration ,rating
from film
group by rating
having average_duration>='00:02:00' ;
-- Bonus: determine which last names are not repeated in the table actor.
select distinct last_name 
from actor 
group by last_name
having count(distinct last_name)=1
;