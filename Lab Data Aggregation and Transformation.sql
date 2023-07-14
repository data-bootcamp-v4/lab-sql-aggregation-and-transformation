-- Challenge 1

use sakila;
-- 1. As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:
-- 1.1 Determine the **shortest and longest movie durations** and name the values as max_duration and min_duration.
select min(length) as min_duration, max(length) as "max_duration" from film;

-- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals. *Hint: look for floor and round functions.*
select floor(avg(length)/60) as "hour" , round((avg(length)/60-floor(avg(length)/60))*60) as "minute" from film; 

-- 2. We need to use SQL to help us gain insights into our business operations related to rental dates:
-- 2.1 Calculate the **number of days that the company has been operating**. *Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.*
select datediff(max(rental_date),min(rental_date)) from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. Return 20 rows of results.
select *, month(rental_date) as "month of rental", weekday(rental_date) as "weekday of rental" from rental limit 20;

-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values **'weekend' or 'workday'**, depending on the day of the week. *Hint: use a conditional expression.*
select *, 
case when weekday(rental_date) < 5 then "weekday" else "weekend" end as "DAY_TYPE"
from rental;

-- 3. We need to ensure that our customers can easily access information about our movie collection. To achieve this, retrieve the **film titles and their rental duration**. If any rental duration value is **NULL, replace** it with the string **'Not Available'**. Sort the results by the film title in ascending order. *Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.*
select title, coalesce(rental_duration,"Not Available") as "rental duration" from film order by rental_duration;

-- 4. As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers. To achieve this, we want to retrieve the **concatenated first and last names of our customers**, along with the **first 3 characters of their email** address, so that we can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier for us to use the data.
select concat(first_name," ",last_name) as "name", left(email, 3) as "email" from customer order by last_name;

-- Challenge 2
-- 1. We need to analyze the films in our collection to gain insights into our business operations. Using the film table, determine:
-- 1.1 The **total number of films** that have been released.
select count(distinct film_id) from film;

-- 1.2 The **number of films for each rating**.
select rating, count(1) from film group by rating;

-- 1.3 The **number of films for each rating, and sort** the results in descending order of the number of films.
select rating, count(1) from film group by rating order by count(1) desc;

-- 2. We need to track the performance of our employees. Using the rental table, determine the **number of rentals processed by each employee**. This will help us identify our top-performing employees and areas where additional training may be necessary.
select staff_id, count(1) as "number of rentals" from rental group by staff_id;

-- 3. Using the film table, determine:
-- 3.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help us identify popular movie lengths for each category.
Select rating, round(avg(length),2) as "average length" from film group by rating order by avg(length) desc;

-- 3.2 Identify **which ratings have a mean duration of over two hours**, to help us select films for customers who prefer longer movies.
Select rating, round(avg(length),2) as "average length" from film group by rating having avg(length) > 120;

-- 4. Determine which last names are not repeated in the table actor.
Select last_name from actor group by last_name having count(1) = 1;