#You need to use SQL built-in functions to gain insights relating to the duration of movies:
use sakila;

# Challenge 1


# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select * from film;
select max(length) as max_duration, min(length) as min_duration from film;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select * from film;
select round(avg(length)) as avg_duration_min, round(avg(length)/60) as avg_duration_hour from film;

#You need to gain insights related to rental dates:
# 2.1 Calculate the number of days that the company has been operating.
# Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select * from rental;
select datediff(max(rental_date),min(rental_date)) as no_of_years_copany_working from rental;

# 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *, monthname(rental_date)as rental_month, dayname(rental_date) rental_day from rental limit 20;

# 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday',
# depending on the day of the week.
# Hint: use a conditional expression.
select *, 
case 
	when dayofweek(rental_date) in(1,7) then 'weekend'
    else 'workday'
end as day_type 
from rental;

# You need to ensure that customers can easily access information about the movie collection. 
# To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, 
# replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
# Please note that even if there are currently no null values in the rental duration column, 
# the query should still be written to handle such cases in the future.
# Hint: Look for the IFNULL() function.


# Challenge 2


# 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
# 1.1 The total number of films that have been released.
select * from film;
select count(*) as total_films from film;

# 1.2 The number of films for each rating.
select rating, count(*) as number_of_films from film
group by rating order by rating;

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
# This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select rating, count(*) as number_of_films from film
group by rating order by number_of_films desc;

# 2. Using the film table, determine:
# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
# Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select rating, round(avg(length),2) as avg_film_length from film
group by rating order by avg_film_length desc;

# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, round(avg(length),2) as avg_film_length from film
group by rating having avg_film_length > 120
order by avg_film_length desc;

# Bonus: determine which last names are not repeated in the table actor.
select * from actor;
select last_name,count(*) as count_of_lstname from actor
group by last_name having count_of_lstname < 2;
