use sakila;

show tables;

#1.1
select title, length as min_duration
from film
order by min_duration asc
limit 1
;

select title, length as max_duration
from film
order by max_duration desc
limit 1
;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select 
    FLOOR(AVG(length) / 60) AS hours,
    FLOOR(AVG(length) % 60) AS minutes
from film
;

#2.1 Calculate the number of days that the company has been operating.
select datediff(max(rental_date), min(rental_date)) as days_operating
from rental
;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *, date_format(rental_date, '%M') as month, date_format(rental_date, '%a') as weekday
from rental
limit 20
;

#2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
select *,
	case
		when date_format(rental_date, '%w') in ('0','6') then 'weekend'
        else 'workday'
	end as day_type
from rental;


# 3
select title, ifnull(rental_duration,'Not Available') as days_rented
from film
order by title
;

select title, 
	case
		when isnull(rental_duration) then 'Not Available'
        else rental_duration
	end as days_rented
from film
;

# Challenge 2
# 1.1 The total number of films that have been released.
select count(film_id) as films_released
from film
;

# 1.2 The number of films for each rating.
select rating, count(film_id) as number_of_films
from film
group by rating
;

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films.
select distinct rating, count(film_id) as number_of_films
from film
group by rating
order by  number_of_films desc
;

# Using the film table, determine:
# 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.
select rating, round(avg(length),2) as average_film_dur
from film
group by rating
order by average_film_dur desc
;
# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, round(avg(length),2) as average_film_dur
from film
group by rating
having average_film_dur > 120
order by average_film_dur desc
;

# Bonus: determine which last names are not repeated in the table actor.
select distinct last_name
from actor
group by last_name
having count(*) = 1;
;