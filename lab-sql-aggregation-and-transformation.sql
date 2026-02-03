-- sakila database queries

use sakila;

-- challenge 1

-- 1.1 shortest and longest movies
select 
    max(length) as max_duration,
    min(length) as min_duration
from film;

-- 1.2 average movie duration in hours and mins
select 
    floor(avg(length)/60) as hours,
    floor(avg(length)%60) as minutes
from film;

-- 2.1 how many days has company been operating
select 
    datediff(max(rental_date),min(rental_date)) as days_operating
from rental;

-- 2.2 rental info with month and weekday
select 
    *,
    month(rental_date) as rental_month,
    dayname(rental_date) as rental_weekday
from rental
limit 20;

-- 2.3 bonus - weekend or workday
select 
    *,
    case 
        when dayofweek(rental_date) in (1,7) then 'weekend'
        else 'workday'
    end as day_type
from rental
limit 20;

-- 3 film titles and rental duration
select 
    title,
    ifnull(rental_duration,'Not Available') as rental_duration
from film
order by title asc;

-- 4 bonus - customer names and email
select 
    concat(first_name,' ',last_name) as full_name,
    left(email,3) as email_prefix
from customer
order by last_name asc;


-- challenge 2

-- 1.1 total films
select count(*) as total_films
from film;

-- 1.2 films per rating
select 
    rating,
    count(*) as number_of_films
from film
group by rating;

-- 1.3 same but sorted
select 
    rating,
    count(*) as number_of_films
from film
group by rating
order by number_of_films desc;

-- 2.1 average duration per rating
select 
    rating,
    round(avg(length),2) as average_duration
from film
group by rating
order by average_duration desc;

-- 2.2 ratings over 2 hours
select 
    rating,
    round(avg(length),2) as average_duration
from film
group by rating
having avg(length)>120
order by average_duration desc;

-- 3 bonus - unique last names
select last_name
from actor
group by last_name
having count(*)=1;