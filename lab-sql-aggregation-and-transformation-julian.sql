

-- challenge 1

-- Q1.1.1 (shortest & longest movie


select 
	max(length) as max_duration,
    min(length) as min_duration
from film
;

-- Q1.1.2

Select  
	floor(avg(length)/60) as avg_film_hours,
    floor(avg(length)%60) as avg_film_minutes
from film
;

-- Q2.1

select 
	max(rental_date) as max,
    min(rental_date) as min
from rental
;


select 
	datediff(max(rental_date), min(rental_date)) as days_operating
from rental
;


-- Q2.2

select *,
	month(rental_date) as month,
    dayname(rental_date) as rental_weekday
from rental
limit 20
;

-- Q2.3

select 
	*,
    month(rental_date) as month,
    dayname(rental_date) as rental_weekday,
    Case
		when dayofweek(rental_date) in (1,7) then "weekend"
        else "workweek"
	end as Day_Type
    
from rental
;



-- Q3

select title, length,
	ifnull(length, "not available") as length
from film
;

-- Q4

select *,
	concat(first_name, " ", last_name) as customer_name,
    left(email, 3) as email_info
from customer
order by last_name asc
;

-- Challenge 2
-- 2: 1.1
select count(*) total_film
from film
;

-- 2: 1.2

select rating,
	count(title) as n_of_film
from film
group by rating
;

-- 2: 1.3
select rating,
	count(title) as n_of_film
from film
group by rating
order by n_of_film DESC
;



-- 2: 2.1
select rating,
	count(title) as n_of_film,
	round(AVG(length), 2) as avg_duration
from film
group by rating
order by avg_duration DESC
;

-- 2: 2.1

select rating,
	count(title) as n_of_film,
	round(AVG(length), 2) as avg_duration
from film
group by rating
having avg_duration > 120
order by avg_duration DESC
;

-- Bonus 

select last_name
from actor
group by last_name
having count(*) = 1
;





