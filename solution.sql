-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
use sakila;
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

select max(length) as max_duration, min(length) as min_duration from sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select floor(avg(length)/60) as avg_hours,
round(avg(length)%60) as avg_minutes from sakila.film;

-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select * from sakila.rental;
select DATEDIFF(max(rental_date), min(rental_date)) from sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select rental_date, date_format(convert(rental_date,date), '%M') as Month_of_the_rental, 
date_format(convert(rental_date,date), '%D') as day_of_the_rental FROM sakila.rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
select rental_date, date_format(convert(rental_date,date), '%M') as Month_of_the_rental, 
date_format(convert(rental_date,date), '%D') as day_of_the_rental, 
IF(DAYOFWEEK(rental_date) IN (1,7), 'weekend', 'workday') AS day_type
FROM sakila.rental;
-- Hint: use a conditional expression.
-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
select concat(last_name, " ", first_name) as Name, Left(email,3) as email from sakila.customer
order by last_name asc;
-- challenge2
-- 1.1 The total number of films that have been released.
select count(film_id) from sakila.film;
-- 1.2 The number of films for each rating.
Select count(film_id), rating from sakila.film
group by rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and 
-- adjust purchasing decisions accordingly.
Select count(film_id) as Number_of_movies, rating as rating from sakila.film
group by rating
order by Number_of_movies desc;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select * from film;
select round(avg(length),2) as avg_duration, rating from sakila.film
group by rating
order by avg_duration desc;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select round(avg(length),2) as avg_duration, rating from sakila.film
group by rating
having avg(length) > 120;
-- determine which last names are not repeated in the table actor
SELECT last_name FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;
