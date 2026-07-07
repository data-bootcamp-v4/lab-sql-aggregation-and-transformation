Use Sakila;
show tables; 

-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

select length from film;
select Max(length) as max_duration from sakila.film;
select min(length) as min_duration from sakila.film;


-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

select round(avg(length),1) from sakila.film;

select floor(avg(length) / 60 ) as avg_hours,	
       round(avg(length) / 60 ) as avg_minutes
from film;

-- You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

select 
DATEDIFF(Max(rental_date),  Min(rental_date)) as Operating_days
from rental;


-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select rental_id, rental_date,
monthname(rental_date) as rental_month,
dayname(rental_date) as rental_weekday
 from rental
Limit 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.

select rental_id, rental_date,
dayname(rental_date) as rental_weekday,
case
when dayname(rental_date) in ("saturday", "sunday") then "Weekend"
else "Workday"
end as DAy_type
from rental;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

select title, rental_duration from film;
select isnull(title) from Sakila.film;
select isnull(rental_duration)from Sakila.film;

SELECT title, 
       IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- to check any null available 
SELECT title, 
       IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
WHERE rental_duration IS NULL;

-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.

select count(film_id) as Total_films  from sakila.film;

-- 1.2 The number of films for each rating.

select rating, count(film_id) as no_of_fims
from film
group by rating;


-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.c


select rating, count(film_id) as no_of_fims
from film
group by rating
order by no_of_fims desc;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. 
-- This will help identify popular movie lengths for each category.

select rating, round(avg(length),2) as mean_duration
from film
group by rating
order by mean_duration desc;



-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.


select rating, round(avg(length),2) as mean_duration
from film
group by rating
Having mean_duration > 120;

-- Bonus: determine which last names are not repeated in the table actor.

select last_name
from actor
group by last_name
Having count(last_name) = 1;


