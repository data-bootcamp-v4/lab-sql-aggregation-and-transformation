use sakila;
-- Challenge 1
-- You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select min(length) as min_duration, max(length) as max_duration from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select floor(avg(length) / 60) as average_hour_duration, floor(avg(length) % 60) as average_min_duration from film;

-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating
select datediff(max(rental_date), min(rental_date)) as operating_days from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *,
date_format(rental_date, "%M") as rental_month,
date_format(rental_date, "%W") as rental_weekday
from rental
limit 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
select *,
case
when dayname(rental_date) in ("Saturday", "Sunday") then "weekend"
else "workday"
end as day_type
from rental;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
select title, ifnull(rental_duration, "Not Available") as rental_duration
from film
order by title asc;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
select concat(first_name, " ", last_name) as full_name, left(email, 3) as email_prefix
from customer
order by last_name asc;

-- Challenge 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(distinct title) from film;

-- 1.2 The number of films for each rating.
select rating, count(title) as number_of_films from film
group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select rating, count(title) as number_of_films from film
group by rating
order by number_of_films desc;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select rating, round(avg(length), 2) as mean_duration
from film
group by rating
order by mean_duration desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, round(avg(length), 2) as mean_duration
from film
group by rating
having avg(length) > 120
order by mean_duration desc;

-- Bonus: determine which last names are not repeated in the table actor.
select last_name from actor
group by last_name
having count(last_name) = 1;

