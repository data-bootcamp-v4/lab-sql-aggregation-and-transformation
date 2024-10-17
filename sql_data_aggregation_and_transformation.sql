-- SQL Data Aggregation and Transformation

-- Challenge 1

-- 1.1. shortest and longest movie durations

select max(length) as max_duration, min(length) as min_duration from film;

-- 1.2. Average movie duration in hours and minutes

select floor(avg(length) / 60) as avg_hours, round(avg(length) % 60, 0) as avg_minutes from film;

-- 2.1. number of days that the company has been operating

select datediff(max(rental_date), min(rental_date)) as days from rental;

-- 2.2. rental information plus moth and weekday

select *, monthname(rental_date) as month, dayname(rental_date) as day from rental limit 20;

-- 2.3. rental information plus day type (weekend or weekday)

select *,
       case
            when dayname(rental_date) in ('Saturday', 'Sunday')
            then 'weekend'
            else 'weekday'
       end as day_type
from rental;

-- 3. film title and rental duration. When rental duration is null, it is
-- replaced by 'Not Available'. Sorted in ascending order
select title, ifnull(rental_duration,'Not Available') as duration
from film
order by title asc;

-- 4. First and last name of customers plus first three letters of their email address

select concat(first_name, ' ', last_name, ' - ', substring(email, 1, 3))
from customer
order by last_name;


-- Challenge 2

-- 1.1. number of released films. i.e. films with release_year not null

select title from film where release_year is not null;

-- 1.2. number of films for each rating

select rating, count(*) as number from film group by rating;

-- 1.3. number of films for each rating, sorted in descending order of the number of films.

select rating, count(*) as number from film group by rating order by number desc;

-- 2.1. mean film duration for each rating, sorted in descending order of the
-- mean. average length is rounded to two decimal places.

select rating, round(avg(length), 2) as avg_duration
from film group by rating order by avg_duration desc;

-- 2.2. ratings with a mean duration greater than two hours (120 mins)

select rating, round(avg(length), 2) as avg_duration
from film
group by rating having avg_duration > 120
order by avg_duration desc;
