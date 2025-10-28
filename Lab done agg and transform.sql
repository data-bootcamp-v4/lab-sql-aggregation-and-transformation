use sakila;
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
	--  1.1 Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.
	-- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
      -- *Hint: Look for floor and round functions.*

select title, length from film;
select max(length) as max_duration, min(length) as min_duration from film;

select floor(avg(length)),
floor(avg(length) / 60) as hours,
floor(avg(length)) % 60 as minutes 
from film;

-- You need to gain insights related to rental dates:
	-- 2.1 Calculate the **number of days that the company has been operating**.
      -- *Hint: To do this, use the `rental` table, and the `DATEDIFF()` function to subtract the earliest date in the `rental_date` column from the latest date.*
      
select DATEDIFF(max(rental_date), min(rental_date)) AS days_of_operation
from rental;

	-- 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
    
select *, month(rental_date) as rental_month,
dayname(rental_date) as rental_weekday
from rental
limit 20;

	-- 2.3 *Bonus: Retrieve rental information and add an additional column called `DAY_TYPE` with values **'weekend' or 'workday'**, depending on the day of the week.*
      -- *Hint: use a conditional expression.*
      
select *, month(rental_date) as rental_month,
dayname(rental_date) as rental_weekday,
case
    when dayofweek(rental_date)= 1 then 'weekend'
    when dayofweek(rental_date)= 7 then 'weekend'
    else 'workday'
end as 'DAY_TYPE'
from rental;

-- You need to ensure that customers can easily access information about the movie collection. 
-- To achieve this, retrieve the **film titles and their rental duration**. 
-- If any rental duration value is **NULL, replace** it with the string **'Not Available'**. Sort the results of the film title in ascending order.
    -- *Please note that even if there are currently no null values in the rental duration column, 
    -- the query should still be written to handle such cases in the future.*
    -- *Hint: Look for the `IFNULL()` function.*
    
select title, rental_duration,
ifnull(rental_duration, 'Not Available') as rental_duration
 from film
 order by title asc;
 
-- *Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
-- To achieve this, you need to retrieve the **concatenated first and last names of customers**, 
-- along with the **first 3 characters of their email** address, so that you can address them by their first name 
-- and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data.*

select concat(last_name, "  ", first_name) as customer, 
left(email, 3) as email_prafix from customer
order by last_name asc;

-- Challenge 2

-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the `film` table, determine:
	-- 1.1 The **total number of films** that have been released.
    
    select count(*)
 from film
 where release_year < 2025;
 
	-- 1.2 The **number of films for each rating**.
    
    select rating, count(*) as number_of_film
    from film
    group by rating;
    
	-- 1.3 The **number of films for each rating, sorting** the results in descending order of the number of films.
      select rating, count(*) as number_of_film
    from film
    group by rating
    order by rating desc;
    
	-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
   
   -- Using the `film` table, determine:
   -- 2.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. 
   
   select * from film;
   
   select rating, avg(length) as mean_film_duration from film
   group by rating
   order by mean_film_duration desc;
      
   -- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
   
    select rating, round(avg(length), 2) as mean_film_duration
    from film
   group by rating
   order by mean_film_duration desc;
   
	-- 2.2 Identify **which ratings have a mean duration of over two hours** in order to help select films for customers who prefer longer movies.

select rating, avg(length) as mean_film_duration
from film
group by rating
having avg(length) > 120
order by mean_film_duration desc;
 
 -- *Bonus: determine which last names are not repeated in the table `actor`.*
 
 select last_name from actor
 group by last_name
 having count(*) = 1;
      
      

