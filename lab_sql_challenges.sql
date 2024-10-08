-- Challenge 1
-- 1.1 Shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.1 Number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_of_operation
FROM rental;

-- 2.2 Rental information with month and weekday
SELECT 
    rental_id, 
    rental_date, 
    MONTHNAME(rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Rental day type (Weekend or Workday)
SELECT 
    rental_id, 
    rental_date, 
    CASE 
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'Weekend' 
        ELSE 'Workday' 
    END AS day_type
FROM rental
LIMIT 20;

-- 3. Film titles and rental duration (handle NULL)
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. Bonus: Concatenated names and email prefix
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1 Total number of films
SELECT 
    COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films per rating
SELECT 
    rating, 
    COUNT(*) AS num_films
FROM film
GROUP BY rating;

-- 1.3 Number of films per rating, ordered descending
SELECT 
    rating, 
    COUNT(*) AS num_films
FROM film
GROUP BY rating
ORDER BY num_films DESC;

-- 2.1 Mean film duration per rating
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 Ratings with a mean duration over two hours
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;

-- 3. Bonus: Unique last names in the actor table
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;