-- Challenge 1: Movie Duration & Rental Insights
-- 1.1 Shortest and longest movie durations
-- 1.2 Average duration in hours and minutes
-- 2.1 Number of days the company has been operating
-- 2.2 Show rental month and weekday (20 rows)
-- 2.3 BONUS: Add DAY_TYPE column (workday/weekend)
-- 3.1 Show title and rental duration (if null → "Not Available")
-- 3.2 BONUS: First+last name + first 3 characters of email
-- 1.1 Shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;
-- 1.2 Average duration in hours and minutes
SELECT 
    FLOOR(AVG(length)/60) AS avg_hours,
    ROUND(AVG(length)%60) AS avg_minutes
FROM film;
-- 2.1 Number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;
-- 2.2 Show rental month and weekday (20 rows)
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
-- 2.3 BONUS: Add DAY_TYPE column
SELECT 
    rental_id,
    rental_date,
    DAYNAME(rental_date) AS rental_day,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;
-- 3.1 Show title and rental duration with fallback for NULL
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;
-- 3.2 BONUS: Concatenated name and email snippet
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- CHALLENGE 2


-- 1.1 Total number of films released
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films by rating
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;

-- 1.3 Number of films by rating (sorted descending)
SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

-- 2.1 Mean film duration per rating (rounded to 2 decimals)
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 Ratings with mean duration over 2 hours
SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- BONUS: Last names not repeated in actor table
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
------
-------

-- Challenge 3 Buisness Insights


SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_paid DESC
LIMIT 10;
SELECT 
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY total_rentals DESC
LIMIT 5;
SELECT COUNT(*) AS active_customers
FROM customer
WHERE active = 1;
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_id IS NULL;
SELECT 
    ROUND(SUM(amount) / COUNT(DISTINCT rental_id), 2) AS avg_payment_per_rental
FROM payment;
