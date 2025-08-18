# 1.You need to use SQL built-in functions to gain insights relating to the duration of movies:
use sakila;

# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration:

select max(length) as max_duration, min(length) as min_duration from sakila.film;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals:
#		Hint: Look for floor and round functions.

select floor(avg(length)) as duration_min, round(avg(length)/60) as durantion_hour from sakila.film;

# You need to gain insights related to rental dates:
# 2.1 Calculate the number of days that the company has been operating.

select min(left(rental_date, 10)) as date,
	   max(left(rental_date, 10))
from sakila.rental;
select distinct datediff(MAX(rental_date), Min(rental_date)) as DateOps from sakila.rental;

# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results:

select*, date_format(convert(left(rental_date, 10), date), '%M') as Month,
		 date_format(convert(left(rental_date, 10), date), '%a') as Weekday
from sakila.rental;

# 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
# Hint: use a conditional expression.

# 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
# If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
# Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
# Hint: Look for the IFNULL() function.

select title,
      ifnull(rental_duration, 'Not Available') as rental_durantion
from sakila.film
order by title asc;

# 4. Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. 
# To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
# so that you can address them by their first name and use their email address to send personalized recommendations. 
# The results should be ordered by last name in ascending order to make it easier to use the data.

select concat(first_name,' ', last_name) as Name,
       left(email, 3) as Email
from sakila.customer
order by last_name asc;

# Challenge 2

# Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:

# 2.1.1 The total number of films that have been released.

select count(film_id) from sakila.film;

# 2.1.2 The number of films for each rating.

select count(film_id) as film_per_rating,
	   rating
from film
Group by rating;

# 2.1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
#     This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

select count(film_id) as film_per_rating,
	   rating
from film
Group by rating
order by film_per_rating desc;

# Using the film table, determine:
# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. 
#     This will help identify popular movie lengths for each category.

select rating, 
       round(avg(length), 2) as mean_duration
from film
group by rating
order by mean_duration desc;

# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

select round(avg(length)/60, 2) as mean_duration
from film
group by rating
having mean_duration = mean_duration >= 2;

