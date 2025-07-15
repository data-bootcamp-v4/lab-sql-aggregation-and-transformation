use sakila;
-- Challenge 1
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select 
max(length) as max_duration, min(length) as min_duration 
from film;
-- 1.2
select floor(avg(length)) from film; -- 115 min

-- 2.1 
select datediff(max(rental_date), min(rental_date))
from rental;

-- 2.2
alter table rental
add column month_of_rental varchar(20);

alter table rental
add column day_of_rental varchar(10);

select 
	rental_id,
    rental_date,
    case
		when dayname(rental_date) in ("Saturday", "Sunday")
        then "weekend"
        else "weekday"
	end as day_type
from
	rental;
    
select 
	title,
    ifnull(rental_duration, "Not Available") as rental_duration
from film 
order by title asc;

select *, concat(first_name, " ", last_name) as "customer names",
left (email, 3) as email_prefix
from customer
order by last_name asc;

-- Challenge 2
select count(*) film_id from film;
select count(*) rating from film;
select rating from film
order by rating desc;

select rating, round(avg(length), 2) as avg_lenght
from film 
group by rating
order by avg_lenght desc;


select rating, round(avg(length), 2) as avg_length
from film
group by rating
having avg(length) > 120;

-- bonus
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;






