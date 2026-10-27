USE sakila;
-- Challenge 1
-- 1.You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration

SELECT min(length) as min_duration, max(length) as max_duration from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.

SELECT floor(avg(length)/60) as hours, round(avg(length)%60) as minutes from film; 

-- Hint: Look for floor and round functions.

-- 2.You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.

select DATEDIFF(max(rental_date), min(rental_date)) as operating_days from rental;

-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select *,DATE_FORMAT(substring_index(rental_date,' ',1),'%M') AS month,
	   DATE_FORMAT(substring_index(rental_date,' ',1),'%W') AS weekday
from rental
LIMIT 20; 
		
-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.

select *,DATE_FORMAT(substring_index(rental_date,' ',1),'%M') AS month,
	   DATE_FORMAT(substring_index(rental_date,' ',1),'%W') AS weekday,
       CASE
       WHEN DATE_FORMAT(substring_index(rental_date,' ',1),'%w') IN (1,2,3,4,5) THEN 'workday'
	   WHEN DATE_FORMAT(substring_index(rental_date,' ',1),'%w') IN (6,7) THEN 'weekend'
	   END AS DAY_TYPE
from rental; 

-- 3.You need to ensure that customers can easily access information about the movie collection.
-- To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle 
-- Hint: Look for the IFNULL() function.

SELECT title,
IFNULL(rental_duration,'Not Available') as rental_duration
from film 
order by title;

-- 4.Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
select concat(first_name,' ',last_name),left(email,3) as email from customer order by last_name;

-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(*) from film;

-- 1.2 The number of films for each rating.

select count(*) as no_of_films,rating
from film 
group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

select count(*) as no_of_films,rating
from film 
group by rating
order by no_of_films desc;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

select rating,round(avg(length),2) as Film_duration
from film
group by rating
order by Film_duration desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

select rating,round(avg(length),2) as Film_duration
from film
group by rating
having Film_duration > 120
order by Film_duration desc;

-- Bonus: determine which last names are not repeated in the table actor.

select last_name,count(last_name) as count 
from actor
group by last_name
having count = 1;
