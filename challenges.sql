USE sakila;

SELECT 
    max(LENGTH) as max_duration, min(LENGTH) as min_duration
FROM film;

select 
    FLOOR(AVG(LENGTH)/60) as average_duration_hour,
    FLOOR(AVG(LENGTH)%60) as average_duration_min
from FILM;

select
    DATEDIFF(max(rental_date), min(rental_date)) as days_of_operation
from rental;

select *,
    MONTHNAME(rental_date) as month_name,
    DAYNAME(rental_date) as day_name,
    CASE 
        WHEN WEEKDAY(rental_date) in (5, 6) THEN 'Weekend'
        ELSE 'Workday'
    END as day_type
from rental
limit 20;

select 
    title,
    IFNULL(rental_duration, 'Not available') as rental_duration
from film
ORDER BY title ASC;

select 
    CONCAT(first_name,' ', last_name, ', ', SUBSTR(email, 1, 3))
from customer
ORDER BY last_name ASC;

-- The total number of films that have been released
select count(*) as total_films from film;

-- The number of films for each rating, sorting the results in descending order of the number of films
select rating, count(*) from film
group by rating
order by count(*) desc;

--  The mean film duration for each rating, and sort the results in descending order of the mean duration
select rating, ROUND(AVG(LENGTH), 2) as mean_film_duration from film
group by rating
order by AVG(LENGTH) desc;

-- Identify which ratings have a mean duration of over two hours
select rating, ROUND(AVG(LENGTH), 2) as mean_film_duration from film
group by rating
HAVING AVG(LENGTH) >= 120
order by AVG(LENGTH) desc;

SELECT last_name, count(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;