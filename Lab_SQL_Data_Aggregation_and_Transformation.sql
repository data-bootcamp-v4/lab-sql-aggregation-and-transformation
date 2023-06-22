1 Challenge

use sakila

As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:

1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

select max(length) as max_duration, min(length) as min_duration from film

1.2. Express the average movie duration in hours and minutes. Dont use decimals. Hint: look for floor and round functions.

select CONCAT(FLOOR(AVG(length)/60), ' hours ', round(AVG(length)%60,0), ' minutes') as average_movie_duration from film

2. We need to use SQL to help us gain insights into our business operations related to rental dates:

2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

select datediff(max(rental_date), min(rental_date)) as operating_days from rental

2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select *, monthname(rental_date) as rental_month, monthname(return_date) as return_month, dayname(rental_date) as rental_weekday, dayname(return_date) as return_weekday from rental 
limit 20 

2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.

select *,
			monthname(rental_date) as rental_month,
			monthname(return_date) as return_month,
			WEEKDAY(rental_date) as rental_weekday,
			WEEKDAY(return_date) as return_weekday,
       CASE
			WHEN WEEKDAY(rental_date) IN (1,7) THEN 'weekend'
			ELSE 'workday'
		END AS day_type_rental
from rental
limit 20;

3. We need to ensure that our customers can easily access information about our movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results by the film title in ascending order. Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.

select title,
		case
			when rental_duration is null then 'Not Available'
			else rental_duration
		end as rental_duration
from film
order by title asc;

4. As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers. To achieve this, we want to retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address, so that we can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier for us to use the data.

select concat(first_name, ' ', last_name) as client_name,
       left(email, 3) as beg_email
from customer
order by last_name asc;

2. Challenge

1.We need to analyze the films in our collection to gain insights into our business operations. Using the film table, determine:

1.1 The total number of films that have been released.

select count(distinct film_id) total_released_film from film

1.2 The number of films for each rating.

select rating, count(*) as film_count
from film
group by rating;

1.3 The number of films for each rating, and sort the results in descending order of the number of films. This will help us better understand the popularity of different film ratings and adjust our purchasing decisions accordingly.

select rating, count(*) as film_count
from film
group by rating
order by film_count desc;

2. We need to track the performance of our employees. Using the rental table, determine the number of rentals processed by each employee. This will help us identify our top-performing employees and areas where additional training may be necessary.

select staff_id, count(rental_id) 
from rental
group by staff_id;

3. Using the film table, determine:

3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help us identify popular movie lengths for each category.

select round(avg(length), 2) as average_movie_duration, rating, count(*) as film_count
from film
group by rating
order by film_count desc;

3.2 Identify which ratings have a mean duration of over two hours, to help us select films for customers who prefer longer movies.

select round(avg(length), 2) > 120 as average_movie_duration, rating, count(*) as film_count
from film
group by rating
order by film_count desc;

4. Determine which last names are not repeated in the table actor.

select last_name
from actor
group by last_name
having count(*) = 1;