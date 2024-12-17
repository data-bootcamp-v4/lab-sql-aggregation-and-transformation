-- CHALLENGE 1
-- 1.1
select min(length) as min_duration, max(length) as max_duration
from film;

-- 1.2
select round(length/60, 0) as Hours, (length%60) as Minutes
from sakila.film;

-- 2.1

 select datediff(max_date, min_date)
 from (select min(rental_date) as min_date, max(rental_date) as max_date
		from rental)
        as number_operating_day;

-- 2.2
select rental_date, inventory_id, customer_id, staff_id, last_update, date_format(rental_date, '%m') as month, date_format(rental_date, '%U') as week
from rental
limit 20;

-- 2.3
select rental_date, inventory_id, customer_id, staff_id, last_update, date_format(rental_date, '%m') as month, date_format(rental_date, '%U') as week, date_format(rental_date, '%w') as day_of_the_week
from rental
limit 20;

-- 3
select title, ifnull(rental_duration, 'Not available') as rental_duration
from film
order by title;

-- 4
select concat(first_name, ' ',last_name) as person, left(email, 3) as email_prefix 
from customer;

-- CHALLENGE 2
-- 1.1
select count(distinct(film_id)) as number_of_film
from film;

-- 1.2
select rating, count(distinct(film_id)) as number_of_film
from film
group by rating;

-- 1.3
select rating, count(distinct(film_id)) as number_of_film
from film
group by rating
order by 2 desc;

-- 2.1
SELECT rating, CONCAT(hours, 'h ', minutes, 'm') AS time_format
FROM (
    SELECT rating, 
        ROUND(lengths / 60, 0) AS hours, 
        round(lengths % 60, 0) AS minutes
    FROM ( 
        SELECT AVG(length) AS lengths, rating
        FROM film
        group by rating
    ) AS subquery_avg
) AS subquery_time
order by 2 desc;

-- 3.2
select distinct(last_name) from actor;

    





