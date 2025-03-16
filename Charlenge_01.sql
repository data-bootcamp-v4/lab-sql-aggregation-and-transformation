-- 1.1 Determine the shortest and longest movie durations
SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration
FROM film;

-- 1.2 Calculate the average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60, 0) AS avg_minutes
FROM film;

-- 2.1 Calculate the number of days the company has been operating
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.3 (Bonus) Add a DAY_TYPE column ('weekend' or 'workday')
SELECT 
    rental_id, 
    rental_date, 
    DATE_FORMAT(rental_date, '%W') AS rental_weekday, 
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Workday'
    END AS day_type
FROM rental
LIMIT 20;

-- 3. Retrieve film titles and rental duration, replacing NULL values
SELECT 
    title, 
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4. (Bonus) Concatenate customer names and display the first 3 characters of their email
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;
