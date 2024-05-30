-- Challenge 1 : 
-- 1.1 : 
select 
max(length) as max_durtion,
min(length) as min_duration 
from film;

-- 1.2 : 
select 
round(avg(length)) as  average_movie_duration_min ,
floor(avg(length)/60) as  average_movie_duration_hour
from film;

-- 2.1 : 
select 
max(rental_date) AS max_date, 
min(rental_date) as min_date,
datediff(max(rental_date) , min(rental_date))
from rental;

-- 2.2 and 2.3 : 
select *,
dayofweek(rental_date) as day_of_week,
MONTH(rental_date) as months,
CASE WHEN dayofweek (rental_date) IN (6,7) then 'Weekend'
else 'day of the week'
end as DAY_TYPE
from rental limit 20;

-- 3 : 
select title,
IFNULL(rental_duration, 'not avalable') as rental_duration
from film
order by title;

-- 4 : 
SELECT 
CONCAT(last_name, " ", first_name, " ", left(email, 3) ) AS customer
from customer
order by last_name;

-- Challenge 2 : 
-- 1.1 : 
select count(distinct title) as total_film from film ;
-- 1.2 : 
select rating, count(distinct title) as total_film  from film  group by rating;
-- 1.3 : 
select rating, count(distinct title) as total_film  from film  group by rating order by total_film desc;

-- 2.1 : 
select rating, round(avg(length),2) as avg_duration_film  from film  group by rating order by avg_duration_film desc;
-- 2.2 : 
select rating, round(avg(length),2) as avg_duration_film  from film group by rating having avg_duration_film >120 ;

-- 3 : determine which last names are not repeated in the table actor
select last_name  from actor group by last_name having count(*) = 1;