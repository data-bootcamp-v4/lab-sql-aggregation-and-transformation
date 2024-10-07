## Challenge 1
select max(length) as max_duration, MIN(length) as min_duration
from film;

select floor(avg(length)/60) as avg_hours,
       round(avg(length)/60) as avg_minutes
from film;
## 2.1
select datediff(max(rental_date),min(rental_date)) as operate_days 
from rental;
## 2.2
select rental_id, rental_date,customer_id,
       month(rental_date) as rental_month,
       dayname(rental_date) as rental_weekday
from rental
limit 20;
## 2.3
select rental_id, rental_date,customer_id,
       CASE 
         WHEN DAYOFWEEK(rental_date) in (1,7) then 'weekend'
         ELSE 'workday'
	   END AS DAY_TYPE
from rental;
## 3
select title, 
IFNULL(rental_duration,'Not Available') as rental_duration
from film
order by title ASC;
## 4
select first_name,
       last_name,
	   CONCAT(first_name, ' ',last_name) as full_name,
	   CONCAT(LEFT(email,3),'...') as email_prefix
from customer
order by last_name ASC;


## Challenge 2
select count(*) as total_film_qty
from film
where release_year is not null;

select rating,count(rating) as each_rating_qty
from film
group by rating;

select rating,count(rating) as each_rating_qty
from film
group by rating
order by each_rating_qty DESC;

## 2.1
select rating,
       ROUND(AVG(length),2) as mean_duration
from film
group by rating
order by mean_duration DESC;

## 2.2 from above 2.1 query result we found only rating in PG-13 films have a mean duration over 2 hours.

## 3
select last_name 
from actor
group by last_name
having count(*) =1;

