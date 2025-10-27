use sakila;

-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

select max(length) as "max_duration", min(length) as "min_duration"
from film;

--  Express the average movie duration in hours and minutes. Don't use decimals
select floor(avg(length))
from film;

-- Calculate the number of days that the company has been operating
select datediff(max(rental_date), min(rental_date))
from rental;

-- Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_id, rental_date, 
       MONTH(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT rental_date,
    DAYNAME(rental_date) as rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM
    rental
LIMIT 20;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
select ifnull(rental_duration, "not-available") as "rental_duration", title
from film;

-- Bonus
select concat(first_name, " ", last_name) as "full name", left(email, 3) as "short_email"
from customer
order by last_name;

-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
select count(film_id)
from film;

select count(rating), rating
from film
group by rating;

select count(rating), rating
from film
group by rating
order by count(rating) desc;

-- Using the film table, determine:
select round(avg(length), 2), rating
from film
group by rating
having avg(length) > 120;

-- Bonus: determine which last names are not repeated in the table actor.
select count(last_name), last_name
from actor
group by last_name
having count(last_name) = 1;
