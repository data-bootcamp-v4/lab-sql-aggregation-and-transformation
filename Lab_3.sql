USE sakila;

-- select duration of film
SELECT 
MAX(length) AS max_duration,
MIN(length) AS min_duration
from film;

-- average duration
SELECT
	floor(avg(length) / 60) as hours,
    round(avg(length) % 60) as minutes 
from film;

SELECT * from film;

-- Number of days company has been operating
SELECT
datediff(max(rental_date), min(rental_date)) AS operating_days
from rental;

-- 2.2 Rental info with month and weekday
SELECT
rental_id,
rental_date,
inventory_id,
customer_id,
return_date,
staff_id,
last_update,
monthname(rental_date) as rental_month,
dayname(rental_date) as rental_weekly,
	CASE
		WHEN DAYNAME(rental_date) in ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Workday'
	END AS Day_type
FROM rental
limit 20;

-- Another option
SELECT *
FROM(
SELECT
rental_id,
rental_date,
inventory_id,
customer_id,
return_date,
staff_id,
last_update,
monthname(rental_date) as rental_month,
dayname(rental_date) as rental_weekly,
	CASE
		WHEN DAYNAME(rental_date) in ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Workday'
	END AS Day_type
FROM rental) AS t
WHERE day_type = 'weekend';

-- Romove null
SELECT
	title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
WHERE rental_duration = 'Not Available';

SELECT 
    title,
    IFNULL(NULL, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Concat First and Last name
SELECT
concat(first_name, ' ', last_name) AS full_name,
substring(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
SELECT * from film;
-- total number of film released
SELECT COUNT(*) AS Total_released_movie FROM film;
-- Number of films for each rating
SELECT rating, count(*) AS film_count_by_rating
from film
GROUP BY rating;

--  **number of films for each rating, sorting** the results in descending order of the number of films.
SELECT rating, count(*) AS film_count_by_rating
from film
GROUP BY rating 
ORDER BY film_count_by_rating DESC;

-- **mean film duration for each rating**
SELECT
rating, 
ROUND(avg(length), 2) AS avg_film_duration
FROM film
GROUP BY rating
ORDER BY avg_film_duration DESC;

-- **mean film duration for each rating and more than two hours film
SELECT
rating, 
ROUND(avg(length), 2) AS avg_film_duration
FROM film
GROUP BY rating
having avg_film_duration > 120
ORDER BY avg_film_duration DESC;

-- *Bonus: determine which last names are not repeated in the table `actor`.*
SELECT
last_name FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name ASC
limit 10;