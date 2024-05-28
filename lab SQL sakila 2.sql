-- You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select max(length) as max_duration, min(length) as min_duration
from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions.
select round(avg(length)) as average_duration_min, round(avg(length)/60) as average_duration_h
from film;

-- You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select datediff(max(rental_date), min(rental_date)) as total_operating_days
from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *,
dayname(rental_date) as weekday,
monthname(rental_date) as month
from rental
limit 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.

select *,
case when dayname(rental_date) in ('Saturday', 'Sunday') then 'Weekend' else 'Workday' end as day_type,
dayname(rental_date) as weekday,
monthname(rental_date) as month
from rental;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.


select title, 
ifnull(length, 'Not available') as length
from film
order by title;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters 
-- of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.

select first_name, last_name, email,
concat(first_name, ' ', last_name, ' ', left(email, 3)) as full_name
from customer
order by last_name;

