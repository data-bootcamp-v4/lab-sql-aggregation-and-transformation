use sakila;
# You need to use SQL built-in functions to gain insights relating to the duration of movies:

# 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select max(length) from film as max_duration;
select min(length) from film as min_duration;

# 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select CONCAT(FLOOR(avg(length)/60),'h ',MOD(floor(avg(length)),60),'m') from film;

# You need to gain insights related to rental dates:
#2.1 Calculate the number of days that the company has been operating.
select datediff(max(last_update),min(rental_date)) from rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select * ,
case 
	when rental_date then DATE_FORMAT(rental_date, "%M")
end as month,
case 
	when rental_date then DATE_FORMAT(rental_date, "%a")
end as weekday
from rental
limit 20;

# 3 You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
select title, ifnull(rental_duration, "Not Available") as rental_duration from film;

#Challenge 2
# 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
# 1.1 The total number of films that have been released.
select count(film_id) from film;

# 1.2 The number of films for each rating.
select rating, count(film_id) from film
group by rating;

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select rating, count(film_id) as number_of_films from film
group by rating
order by number_of_films desc;

# Using the film table, determine:
# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select rating, round(avg(length),2) as movie_length from film
group by rating
order by movie_length desc;

# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

select rating, round(avg(length),2) as movie_length,
case
	when round(avg(length),2) > 120 then "Long Movies Available"
    when round(avg(length),2) < 120 then "Long Movies Unvailable"
    
end as long_movies
from film
group by rating


