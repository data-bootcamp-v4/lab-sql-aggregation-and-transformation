-- Challenge 1
-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select * from film;

select min(length) as min_duration, max(length) as max_duration from film;

select title, length length
from film
where length = (select min(length) from film);

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

select title, floor((length)/60) as avg_hours, floor((length)%60) as avg_min from film;

-- You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

select datediff(max(rental_date),min(rental_date)) from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select *, weekday(rental_date) as rental_weekday, month(rental_date) as rental_month from rental limit 20;


-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(*) as number_of_films from film;

-- 1.2 The number of films for each rating.
select 
rating, count(film_id) as number_of_films
from film
group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select 
rating, count(film_id) as number_of_films
from film
group by rating
order by number_of_films desc;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select rating, round(avg(length),2) as avg_duration
from film
group by rating
order by avg_duration desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

select rating, avg(length) as mean_duration
from film
group by rating
having mean_duration > 120;

-- Bonus: determine which last names are not repeated in the table actor.