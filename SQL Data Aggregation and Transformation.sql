-- 1
select max(length) as max_duration
from film;

select min(length) as min_duration
from film;
-- avg duration
SELECT TIME_FORMAT(SEC_TO_TIME(ROUND(AVG(length)) * 60), '%H hours %i minutes') AS avg_duration
FROM film;
-- 2 
SELECT DATEDIFF(min(rental_date), max(rental_date)) AS 'number of days that the company has been operating'
from rental;
-- 2.2
SELECT 
    rental_id,
    customer_id,
    rental_date,
    RETURN_DATE,
    DATE_FORMAT(rental_date, '%M') AS month,       
    DATE_FORMAT(rental_date, '%W') AS weekday     
FROM rental
LIMIT 20;
-- 2.3
SELECT *,
    DATE_FORMAT(rental_date, '%M') AS month,      
    DATE_FORMAT(rental_date, '%W') AS weekday,    
    CASE 
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type                               
FROM rental;
-- 3
SELECT 
    title AS film_title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
-- 4
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- challenge 2
SELECT COUNT(*) AS total_films
FROM film;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- 2
SELECT rating, COUNT(*) AS film_count,  ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;


