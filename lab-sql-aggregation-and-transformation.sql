#challenge 1
#1.1
select max(length) as max_duration, min(length) as min_duration from sakila.film;
#1.2
select floor(avg(length)/60) as hours, round((avg(length)%60))  as minutes
from sakila.film;

#2.1
SELECT DATEDIFF(
    (SELECT Max(rental_date) FROM sakila.rental), 
    (SELECT min(rental_date) FROM sakila.rental)
) AS DateDifference;

#2.2
WITH RentalInfo AS (
    SELECT rental_id,
           MONTH(rental_date) AS Month,
           DAYNAME(rental_date) AS Weekday
    FROM sakila.rental
)
SELECT sakila.rental.*,
       RentalInfo.Month,
       RentalInfo.Weekday
FROM sakila.rental 
INNER JOIN RentalInfo
ON sakila.rental.rental_id  = RentalInfo.rental_id;

#3
select title, ifnull(rental_duration,Not 'Available') as rental_duration from sakila.film
order by title ASC;

#4 (bonus)
select concat(first_name, " ", last_name) as name, left(email, 3) as email from sakila.customer;

# challenge 2
# 1.1 
select count(title) from sakila.film;

#1.2 
select rating, count(*) as num_movies from sakila.film
group by rating;

#1.3
select rating, count(*) as num_movies from sakila.film
group by rating
order by num_movies DESC;

#2.1
select rating, round(AVG(length),2) avg_duration from sakila.film
group by rating
order by avg_duration DESC;

#2.2
select rating, round(AVG(length),2) avg_duration from sakila.film
group by rating
having avg_duration > 120
order by avg_duration;

#3 (bonus)
select last_name, count(*) as counter from sakila.actor
group by last_name
having counter <=1;