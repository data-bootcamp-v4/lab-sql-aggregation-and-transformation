use sakila;

/*1/
select 
    min(length) AS min_duration,
    max(length) AS max_duration
from film

select 
    concat(
        floor(avg(length)/60), 'h ',
        round(avg(length)) - floor(avg(length)/60)*60, 'm'
    ) AS avg_duration
from film;

/*2/
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
 
SELECT 
    rental.*,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

/*3/
SELECT 
    rental.*,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

/* challenge*/
/*1/
SELECT distinct count(release_year) FROM film;
SELECT rating, COUNT(*) AS film_count FROM film GROUP BY rating;
SELECT rating, COUNT(*) AS film_count
FROM film GROUP BY rating ORDER BY film_count DESC;
/*2/
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating ORDER BY avg_duration DESC;

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating HAVING AVG(length) > 120;
/*3/
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;