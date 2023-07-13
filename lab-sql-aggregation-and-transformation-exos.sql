## Challenge 1


-- 1. As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:
-- 1.1 Determine the **shortest and longest movie durations** and name the values as max_duration and min_duration.

select max(length) as max_lenght, min(length) as min_length
from film;
    
-- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals. *Hint: look for floor and round functions.*

select 
    concat(
        floor(avg(length) / 60), -- Hours
        'h ', 
        round(avg(length) % 60) -- Minutes
    ) as average_length
from film;

-- 2. We need to use SQL to help us gain insights into our business operations related to rental dates:
-- 2.1 Calculate the **number of days that the company has been operating**. 
-- *Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.*

select 
	datediff(MAX(rental_date), min(rental_date)) as days_operating
from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. 
-- Return 20 rows of results.

select
	rental_id, rental_date, month(rental_date) as rental_month from rental limit 20;
    
    --  2.3 Retrieve rental information and add an additional column called DAY_TYPE with values **'weekend' or 'workday'**, depending on the day of the week. 
    -- *Hint: use a conditional expression.*

select 
	rental_id, rental_date,
		case when weekday (rental_date) in (5,6) then 'weekend'
        else 'workday'
	end like day_type
from rental limit 20;

-- 3. We need to ensure that our customers can easily access information about our movie collection. 
-- To achieve this, retrieve the **film titles and their rental duration**. 
-- If any rental duration value is **NULL, replace** it with the string **'Not Available'**. 
-- Sort the results by the film title in ascending order. 
-- *Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.*

select
	film_title, coalesce(rental_duration, 'Not Available') as rental_duration
from film order by film_title asc;

## Challenge 2

-- 1. We need to analyze the films in our collection to gain insights into our business operations. 
-- Using the film table, determine:
-- 1.1 The **total number of films** that have been released.

select
	count(*) as total_number_films
from film;

-- 1.2 The **number of films for each rating**.

select
	rating, count(*) as film_number
from film
group by rating;

-- 1.3 The **number of films for each rating, and sort** the results in descending order of the number of films.
-- This will help us better understand the popularity of different film ratings and adjust our purchasing decisions accordingly.

select
	rating, count(*) as film_number
from film
group by rating
order by film_number desc;

-- 2. We need to track the performance of our employees. 
-- Using the rental table, determine the **number of rentals processed by each employee**. 
-- This will help us identify our top-performing employees and areas where additional training may be necessary.

select
	staff_id, count(*) as rental_number
from rental
group by staff_id;

-- 3. Using the film table, determine:
-- 3.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help us identify popular movie lengths for each category.

select
	rating, round(avg(length), 2) as mean_duration
from film
group by rating
order by mean_duration desc;

-- 3.2 Identify **which ratings have a mean duration of over two hours**, to help us select films for customers who prefer longer movies.

select
	rating, round(avg(length), 2) as mean_duration 
	from film
group by rating
having mean_duration > 120;

-- 4. Determine which last names are not repeated in the table actor.

select actor.last_name,
       count(1) as num_last_names
from actor
group by actor.last_name
having count(actor.last_name) = 1;


    
    
    
