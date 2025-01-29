SELECT length AS max_duration
FROM film
ORDER BY length DESC
LIMIT 1;

SELECT length AS min_duration
FROM film
ORDER BY length
LIMIT 1;

SELECT round(AVG(length),0) as  avg_duration_min
FROM film;

SELECT round(AVG(length),0) as  avg_duration_min
FROM film;

SELECT floor(AVG(length) / 60) AS duration_in_hours
FROM film;

SELECT DATEDIFF(MAX(return_date), MIN(rental_date)) AS total_days_operational
FROM rental;

SELECT rental_date
FROM rental;

SELECT 
    rental_date,
    MONTH(rental_date) AS month,
    DAYNAME(rental_date) AS day_of_week
FROM 
    rental;
    
SELECT 
    rental_date,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (2, 3, 4, 5, 6) THEN 'workday'
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
    END AS day_type
FROM 
    rental;
    
SELECT 
	title, rental_duration
    CAS;
    
    
SELECT 
    title,
    IFNULL(rental_duration, 0) AS rental_duration
FROM 
    film;
    
SELECT 
    title,
    CASE
        WHEN rental_duration = 0 THEN 'Not Available'
        ELSE CAST(rental_duration AS CHAR)
    END AS rental_duration_status
FROM 
    film;
    
SELECT 
    title,
    CASE
        WHEN rental_duration = 0 THEN 'Not Available'
        ELSE CAST(rental_duration AS CHAR)
    END AS rental_duration_status
FROM 
    film;
    
    
SHOW TABLES;
select title, 
	case 
		when isnull(rental_duration) then "Not Available"
        else rental_duration
        end as rental_duration
from film;

select count(*) as total_films
from film;

select rating, count(*) as number_films
from film 
group by rating;

select rating, count(*) as number_of_films
from film
group by rating
order by number_of_films DESC;

select rating, avg(length) as length
from film
group by rating
order by length DESC;

select rating, avg(length) avg_len
from film
group by rating
having avg_len > 120;