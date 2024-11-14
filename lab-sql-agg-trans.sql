use sakila;
-- shortest longest movie --
select max(length) as max_duration, min(length) as min_duration from film;
-- average movie duration--
select floor(avg(length)/ 60) as avg_hours, round(avg(length) % 60) avg_minutes from film;

-- rental dates--
-- 1operatin day of company--
select datediff(max(rental_date), min(rental_date)) as days_operating from rental;
select * from rental;
-- 2month and weekday of rental
select rental_id, rental_date, month(rental_date) as rental_month,
dayofweek(rental_date) as rental_weekday from rental
limit 20;
--  3 add column day_type with weeken workday--
select * from rental;

SELECT 
    rental_id,
    rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM 
    rental
LIMIT 20;

-- film tiles and rental duration(null handeling)--
select * from film;

select title, ifnull(rental_duration, "not available") as rental_duration
from film
order by title asc;

-- conc first and last name--
select concat(first_name, " ", last_name) as full_name,
concat(substring(email, 1,3)) as email_prefix
from customer
order by last_name asc;

-- total number of films released--

select count(film_id) from film;
SELECT COUNT(*) AS total_films FROM film;


-- number of films for each rating--

select rating, count(rating) as num_films from film group by rating;
-- in desc order--
select rating, count(rating) as num_films from film group by rating order by num_films desc;

-- mean fim duration by rating(.2) --
select round(avg(length),2) as avg_duration, 
rating
from film
group by
rating
order by avg_duration desc;

-- >120min duration--
select rating, round(avg(length),2) as avg_duration 
from film
group by
rating
having avg(length)> 120
order by avg_duration desc;

-- last name not repeated from actor--
select last_name from actor group by last_name
having count(last_name)=1;