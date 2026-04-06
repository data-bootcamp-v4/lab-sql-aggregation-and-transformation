-- Challenge 1: Durations, Dates, and Strings
-- 1.1 Movie durations (Min/Max)

SELECT 
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration 
FROM film;


--1.2 Average duration in Hours and Minutes

SELECT 
    CAST(AVG(length) / 60 AS INT) || ' hours ' || 
    CAST(AVG(length) % 60 AS INT) || ' minutes' AS avg_duration
FROM film;


-- 2.1 Days of operation

SELECT 
    ROUND(julianday(MAX(rental_date)) - julianday(MIN(rental_date))) AS days_operating
FROM rental;

-- 2.2 Rental information with Month and Weekday

SELECT *, 
    strftime('%m', rental_date) AS month, 
    strftime('%w', rental_date) AS weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Day Type (Weekend vs Workday)

SELECT *,
    CASE 
        WHEN strftime('%w', rental_date) IN ('0', '6') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;


-- 3. Handling NULLs in Rental Duration

SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- 4. Bonus: Personalized Email Data

SELECT 
    first_name || ' ' || last_name AS full_name,
    SUBSTR(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;


-- Challenge 2: Aggregations and Filtering
-- 1.1 Total films

SELECT COUNT(*) AS total_films FROM film;

-- 1.2 & 1.3 Films per rating (Sorted)

SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1 Mean duration per rating

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Ratings with mean duration > 120 minutes

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;

-- 2.3 Bonus: Non-repeated last names

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

