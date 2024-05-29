use sakila;

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

select min(length) as min_duration, max(length) as max_duration from sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals

select floor(avg(length)/60) as hours, round(mod(avg(length), 60),0) as minutes from sakila.film;

-- 2.1 Calculate the number of days that the company has been operating

select datediff(max(rental_date), min(rental_date)) as rental_days_difference from sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

select *, DATE_FORMAT(CONVERT(rental_date, DATE), '%M') as rental_month, DATE_FORMAT(CONVERT(rental_date, DATE), '%D') as rental_day from sakila.rental;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration.
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

select title,
case
	WHEN rental_duration > 0 then rental_duration
    else "Not avaliable"
end as "rental_duration"
from sakila.film
order by title asc;

-- 1.1 The total number of films that have been released.

select count(film_id) from sakila.film;

-- 1.2 The number of films for each rating.

select rating, count(film_id) from sakila.film
group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
select rating, count(film_id) as number_of_films from sakila.film
group by rating
order by number_of_films desc;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.

select rating, round((sum(length)/count(film_id)),0) as mean_duration from sakila.film
group by rating
order by mean_duration desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, round((sum(length)/count(film_id)),0) as mean_duration from sakila.film
group by rating
having mean_duration > 120
order by mean_duration desc;
