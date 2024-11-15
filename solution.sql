-- Lab solution

-- find shortest and longest movie durations, rename the
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- average movie length in hours and minutes

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- operating days
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- get rental info, add rental's day and month
SELECT 
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20; 

-- add day type column
SELECT 
    rental_id,
    rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental;

-- get film titles and rental duration 
SELECT 
    f.title,
    IFNULL(DATEDIFF(r.return_date, r.rental_date), 'Not Available') AS rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title ASC;

-- first and last names of customers plus first 3 chars of email address
-- sort by last name
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUBSTRING(c.email, 1, 3) AS email_prefix
FROM customer c
ORDER BY c.last_name ASC;

-- Challenge 2

-- total of released films
SELECT COUNT(*) AS total_films
FROM film;


-- film amount per rating
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;


-- films per rating, descending order
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;


-- mean film length per rating (desc)
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;


-- ratings with a mean length longer than 2h
SELECT rating, 
       ROUND(AVG(duration), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(duration) > 120;

-- unique names in actor table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
