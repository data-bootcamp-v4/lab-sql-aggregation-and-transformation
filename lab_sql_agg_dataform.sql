-- challenge 1.1
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- challenge 1.2
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(MOD(AVG(length), 60)) AS avg_minutes
FROM film;


-- question 2.1
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
-- 2.2 grab rental info with month & weekday
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- bonus 2.3
SELECT 
    rental_id,
    rental_date,
    customer_id,
    inventory_id,
    staff_id,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- question 3.1
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- bonus
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- challenge 2 - number of films released
SELECT COUNT(*) AS total_films
FROM film;

-- films per rating
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- films for ea. rating, descending
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY film_count DESC;

-- film DURATION analysis by rating
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- ratings with mean film length more than 2 hours
SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;

-- bonus! unique last names
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;





