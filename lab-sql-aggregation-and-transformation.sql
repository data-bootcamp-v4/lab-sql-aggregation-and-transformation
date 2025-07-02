-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
use sakila;
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

select min(film.length) as min_duration, max(film.length) as max_duration
from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

select round(avg(film.length)/60, 0) as avg_hours, floor(avg(film.length)) as avg_minutes
from sakila.film;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

select datediff(max(CONVERT(rental.rental_date, DATE)), min(CONVERT(rental.rental_date, DATE)))  AS days_opened
from sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select rental_id, customer_id, rental_date, DATE_FORMAT(CONVERT(rental_date, DATE), '%M') as rental_month, DATE_FORMAT(CONVERT(rental_date, DATE), '%W') as weekday_of_rental
from sakila.rental;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.

select rental_id, customer_id, rental_date, DATE_FORMAT(CONVERT(rental_date, DATE), '%a') as 'weekday',
case
when DATE_FORMAT(CONVERT(rental_date, DATE), '%a') in ("Sat", "Sun") then "Weekend"
else "Weekday"
end as DAY_TYPE
from sakila.rental;

-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

select film.title, 
case
when film.rental_duration is null then 'Not Available'
else film.rental_duration 
end as real_rental_duration
from sakila.film
order by film.title asc;



-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

-- Challenge 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(distinct(film_id)) as films_released
from sakila.film;

-- 1.2 The number of films for each rating.
select rating, count(film_id) as number_of_films
from sakila.film
group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select rating, count(film_id) as number_of_films
from sakila.film
group by rating
order by number_of_films desc;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select round(avg(length),2) as average_length, rating
from sakila.film
group by rating
order by rating desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, round(avg(film.length),2) as average_length
from sakila.film
group by rating
having average_length > 120;

-- Bonus: determine which last names are not repeated in the table actor.