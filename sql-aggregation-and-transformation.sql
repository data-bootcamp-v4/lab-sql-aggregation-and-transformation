USE sakila

-- 1.1 Shortest and Longest Movie Durations
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2 Average Movie Duration in Hours and Minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(MOD(AVG(length), 60)) AS avg_minutes
FROM film;

-- 2.1 Number of Days Company Has Been Operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Rental Info + Month and Weekday Columns
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Add DAY_TYPE Column (Weekend or Workday)
SELECT 
    rental_id,
    rental_date,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM rental
LIMIT 20;

-- 3. Film Titles and Rental Duration (Handle NULLs)
SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. Bonus: Personalized Customer Email Campaign Info
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2.1.1 - Total number of films released
SELECT 
    COUNT(*) AS total_films
FROM film;

-- Challenge 2.1.2 - Number of films for each rating
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- Challenge 2.1.3 - Number of films for each rating, sorted descending
SELECT 
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- Challenge 2.2.1 - Mean film duration for each rating, sorted descending
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- Challenge 2.2.2 - Ratings with mean film duration over 2 hours
SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;

-- Challenge 2.3 Bonus - Last names not repeated in actor table
SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;