#Challenge 1


#Solution_1.1

select 
	min(length) as shortest_movie_duration,
	max(length) as longest_movie_duration 
from	
	film;


#Solution_1.2

select 
	avg(length) as avg_movie_duration,
    CONCAT(FLOOR(avg(length)/60), "h ", ROUND(avg(length)%60), "m ")
from	
	film;
 
 
#Solution_2.1

select 
	datediff(max(rental_date), min(rental_date)) as number_of_days
from 
	rental;


#Solution_2.2

select 
	*,
    month(rental_date) as month_of_rental,
    weekday(rental_date) as day_of_rental
from
	rental
limit 20;


#Solution_2.3

select 
	*,
    weekday(rental_date) as day_of_rental,
    CASE 
		WHEN weekday(rental_date) >= 0 and  weekday(rental_date) < 5
			THEN "workday"
        ELSE "weekend"
	END as day_type
from
	rental;


#Solition_3

select
	title,
    IFNULL(rental_duration, "Not Avaliable") as rental_duration
from
	film
order by 
	title asc;
    

#Solution_4: Bonus

select 
	concat(first_name, " ", last_name) as full_name,
    left(email, 3)
from 
	customer
order by 
	last_name asc;
    
    

    
#Challenge 2


#Solution_1.1

select 
	count(film_id) as total_number_of_films
from
	film;
    
    
#Solution_1.2

select 
	rating,
	count(film_id) as total_number_of_films
from
	film
group by
	rating;
    
    
#Solution_1.3

select 
	rating,
	count(film_id) as total_number_of_films
from
	film
group by
	rating
order by 
	total_number_of_films desc;


#Solution_2.1

select 
	rating,
	round(avg(length), 2) as mean_duration
from
	film
group by
	rating
order by 
	mean_duration desc;
    
    
#Solution_2.2

select 
	rating,
	round(avg(length), 2) as mean_duration,
    floor(avg(length)/60) 
from
	film
group by
	rating
having 
	floor(avg(length)/60) >= 2
order by 
	mean_duration desc;
    

#Solution_3

select 
	distinct last_name,
    count(distinct last_name) number_of_repetitions
from
	actor
group by
	last_name
having 
	count(distinct last_name) = 1;