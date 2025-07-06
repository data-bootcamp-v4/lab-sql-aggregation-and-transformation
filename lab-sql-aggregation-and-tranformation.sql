use sakila;
-- Challenge 1 :
-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select max(film.length) as max_duration, min(film.length) as min_duration from sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
select floor((avg(film.length)/60)) as avg_duration_in_hours_low from sakila.film;
select round((avg(film.length)/60)) as avg_duration_in_hours_high from sakila.film;
select round(avg(film.length)) as avg_duration_in_min from sakila.film;

-- You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column 
-- from the latest date.
select datediff(MAX(rental.rental_date),MIN(rental.rental_date)) as number_of_days_company_operating from sakila.rental;


-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *, date_format(rental.rental_date, "%M") as month, dayofweek(rental.rental_date) as weekday  from sakila.rental
limit 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
select *, dayofweek(rental.rental_date) as weekday,
CASE 
	WHEN dayofweek(rental.rental_date) = "1" Then "workday"
    WHEN dayofweek(rental.rental_date) = "2" Then "workday"
    WHEN dayofweek(rental.rental_date) = "3" Then "workday"
    WHEN dayofweek(rental.rental_date) = "4" Then "workday"
    WHEN dayofweek(rental.rental_date) = "5" Then "workday"
	ELSE "weekday"
END AS day_type
FROM sakila.rental;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, 
-- retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 
-- 'Not Available'. Sort the results of the film title in ascending order.
update sakila.film 
set film.length = 'Not Available'
where film.length IS NULL; 

select film.title, film.length from sakila.film
order by film.title asc;

-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of 
-- their email address, so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.
select *, concat(customer.first_name, customer.last_name) AS concat, left(customer.email, 3) from sakila.customer
order by customer.last_name asc;

-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(film.release_year) as number_of_film from sakila.film;

-- 1.2 The number of films for each rating.
select film.rating, count(film.rating) from sakila.film
group by film.rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select film.rating, count(film.rating) from sakila.film
group by film.rating
order by count(film.rating) desc;


-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select film.rating, count(film.rating) as number_of_film_by_rating, round(avg(film.length),2) as average_length from sakila.film
group by film.rating
order by count(film.rating) desc;


-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select film.rating, count(film.rating) as number_of_film_by_rating, round(avg(film.length),2) as average_length from sakila.film
group by film.rating
having average_length > 120
order by count(film.rating) desc;
-- Bonus: determine which last names are not repeated in the table actor.
select actor.last_name, COUNT(distinct actor.last_name) from sakila.actor
GROUP by actor.last_name;