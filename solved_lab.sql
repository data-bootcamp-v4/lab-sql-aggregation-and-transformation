use sakila;

-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration

select max(length) as "max_duration" , min(length) as "min_duration"
from film;

select floor(avg(length))
from film;

-- You need to gain insights related to rental dates:

select datediff(max(rental_date), min(rental_date))
from rental;

SELECT rental_id, rental_date, 
       MONTH(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

SELECT rental_id, rental_date,
       DAYNAME(rental_date) AS rental_weekday,
       CASE 
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental
LIMIT 20;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.

select ifnull(rental_duration, "Not Available") as "rental_duration", title
from film;

-- bonus

select concat(first_name, " ", last_name) as "full_name", left(email, 3) as "short_email"
from customer
order by last_name asc;

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

-- Using the film table, determine: .

select round(avg(length), 2), rating
from film
group by rating
order by round(avg(length), 2) desc;

select round(avg(length), 2), rating
from film
group by rating
having avg(length) > 120;

-- bonus

select count(last_name), last_name
from actor
group by last_name
having count(last_name) = 1;