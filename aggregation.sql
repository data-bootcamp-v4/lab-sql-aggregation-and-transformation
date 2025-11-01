use sakila;
#1.1
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;
#1.2
SELECT 
    CONCAT(
        FLOOR(AVG(length) / 60), ' hours ',
        FLOOR(MOD(AVG(length), 60)), ' minutes'
    ) AS avg_duration
FROM film;

#2.1
SELECT 
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
#2.2
select*,date_format(rental_date,'%M') as month,date_format(rental_date,'%W') as weekday from rental
limit 20;
#2.3
select*,date_format(rental_date,'%W') as weekday ,
case
when date_format(rental_date,'%W')  in ("Monday","Tuesday","Wednesday","Thursday","Friday") then "workday"
else "weekend"
end as day_type
from rental;
#3
select rental_duration from film;
select sum(isnull(rental_duration)) from film;
select title,ifnull(rental_duration,'Not Available') as rental_duration from film
order by title asc;
select concat(first_name," ",last_name) as full_name,substr(email,1,3) as email_prefix from customer
order by last_name;

#challenge 2
#1.1
select count(*) from film;
#1.2
select rating,count(title) as number_of_films from film
group by rating;
#1.3
select rating,count(title) as number_of_films from film
group by rating
order by number_of_films desc;
#2.1
select rating,round(avg(length),2) as avg_duration from film
group by rating
order by avg_duration desc;
#2.2
select rating,round(avg(length),2) as avg_duration from film
group by rating
having avg_duration>120;

#bonus
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1;

