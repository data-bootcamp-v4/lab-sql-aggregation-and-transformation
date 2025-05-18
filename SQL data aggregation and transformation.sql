#CHALLENGE 1 

#1.1. Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select 
	max(f.length) as max_length,
    min(f.length) as min_length,
	round(avg(f.length),0) as average_length_minutes,
    round(avg(f.length)/60,0) as average_length_hours
from sakila.film as f;

#2.1.Calculate the number of days that the company has been operating.
SELECT 
    DATEDIFF(MAX(r.rental_date), MIN(r.rental_date)) AS days_operating
FROM sakila.rental as r;

#2.2.Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
#Return 20 rows of results.

select 
    month(r.rental_date) as month_of_rental,
    dayname(r.rental_date) as day_of_rental
from sakila.rental as r;

#3.You need to ensure that customers can easily access information about the movie collection. 
#To achieve this, retrieve the film titles and their rental duration. 
#If any rental duration value is NULL, replace it with the string 'Not Available'. 
#Sort the results of the film title in ascending order.

select 
	f.title,
    f.rental_duration,
    IFNULL(f.rental_duration, "Not Available") as rental_duration_update
from sakila.film as f
order by f.title asc;

#CHALLENGE 2

#1.1.The total number of films that have been released.
#1.2.The number of films for each rating.
#1.3.The number of films for each rating, sorting the results in descending order of the number of films. 

select 
	count(f.film_id) as total_films_released,
    f.rating
from sakila.film as f
group by f.rating
order by total_films_released desc;

#2.1.The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places.
#This will help identify popular movie lengths for each category.

#2.2.dentify which ratings have a mean duration of over two hours 
#in order to help select films for customers who prefer longer movies.


select 
	f.rating,
    round(avg(f.length),2) as mean_duration,
    case 
		when round(avg(f.length),2) >120 then "Long_movie"
        when round(avg(f.length),2) <120 then "Short_movie"
	end as length_of_movies
from sakila.film as f
group by f.rating
order by mean_duration desc;
    