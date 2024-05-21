-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select
	MAX(length) as max_duration,
    MIN(length) as min_duration
from film ;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- select round(avg(length)/60,2) as hour, round(avg(length)%60,2)as minutes from 
-- select avg(length) from film;-- 
SELECT CONCAT(
    floor(AVG(length)/ 60),
    ':',
    LPAD(floor(AVG(length)% 60), 2, '0')
) AS average_length
FROM film;

-- Hint: Look for floor and round functions.
-- You need to gain insights related to rental dates:

-- 2.1 Calculate the number of days that the company has been operating.
select datediff(max(return_date),min(rental_date)) as day_ops from rental;
-- select max(return_date) , Min(rental_date) from rental;
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *, MONTH(rental_date) as month_rent,WEEKDAY(rental_date) as weekday_rent from rental limit 20;
-- Weekday return weekday index 0=monday 5=sat 6= sunday
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
select *, 
case
	when WEEKDAY(rental_date) <5 then 'workday'
    when WEEKDAY(rental_date) >4 then 'weekend'
    end as 'DAY_TYPE'
from rental;
-- Hint: use a conditional expression.
-- You need to ensure that customers can easily access information about the movie collection. To achieve this, 
-- retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT 
    title,IFNULL(rental_duration, 'Not Available')
FROM film ORDER BY title ASC;

-- Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to 
-- retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT 
    CONCAT(first_name, ' ', last_name) AS FullName,
    SUBSTRING(email, 1, 3) AS EmailPrefix
FROM customer ORDER BY last_name ASC;
-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(*) from film;
-- 1.2 The number of films for each rating.
select rating, count(*) as RateNum from film group by rating order by rating;
-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select rating, count(*) as NumFilm from film group by rating order by NumFilm;
-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.\
select rating, round(avg(length),2) as mean_dur from film group by rating order by mean_dur desc;
-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, avg(length) from film group by rating having avg(length)>120 order by avg(length) desc;
-- Bonus: determine which last names are not repeated in the table actor.
select last_name, count(*) from actor group by last_name having count(*) =1;