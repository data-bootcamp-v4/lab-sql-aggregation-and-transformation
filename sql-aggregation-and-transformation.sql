use sakila;
select max(length) as max_duration, min(length) as min_duration from film;

select floor(avg(length)/60) as hours,
		round(avg(length) % 60,0) as minutes
from film;

SELECT datediff(max(return_date), min(return_date)) AS date_in_bussines
FROM rental;


select *, month(return_date) as month,
			weekday(return_date) as day from rental
            limit 20 ;

select *, 
	case 
		when weekday(return_date) in (5,6) then 'weekend'
        else 'workday'
	end as day_tupe from rental;

select title, 
	ifnull(rental_duration,'Not Available') as rental_duration
from film
order by title asc;

select concat (first_name, ' ', last_name) as full_name,
	left(email,3) as abbr
    from customer
    order by last_name asc;
    
select distinct count(film_id) as total from film;

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

select rating, round(avg(length),2) as average_length
from film
group by rating;

select rating, round(avg(length),2) as average_length
from film
group by rating
having avg(length) > 120;
