USE sakila;



-- CHALLENGE 1
-- 1.1 Shortest and longest movie durations

SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;


-- 1.2 Average movie duration in hours and minutes
-- FLOOR gives us the complete hours
-- MOD gives us the remaining minutes

SELECT
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(MOD(AVG(length), 60)) AS minutes
FROM film;


-- 2. RENTAL DATE ANALYSIS
-- 2.1 Number of days that the company has been operating

SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;


-- 2.2 Rental information + month + weekday
-- Return only 20 rows

SELECT
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;


-- 2.3 BONUS
-- Add DAY_TYPE: weekend or workday

SELECT
    *,
    MONTHNAME(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday')
            THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;


-- 3. FILM TITLES AND RENTAL DURATION

-- IFNULL handles possible NULL values.
-- rental_duration is numeric, so CAST converts it to text
-- to allow 'Not Available' in the same output column.

SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- 4. BONUS - CUSTOMER EMAIL CAMPAIGN

SELECT
    CONCAT(first_name, ' ', last_name) AS customer_name,
    LEFT(email, 3) AS email_first_3_characters
FROM customer
ORDER BY last_name ASC;


-- CHALLENGE 2


-- 1.1 Total number of films

SELECT
    COUNT(*) AS total_films
FROM film;


-- 1.2 Number of films for each rating

SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;


-- 1.3 Number of films for each rating
-- Sort from highest to lowest number of films

SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;


-- 2. FILM DURATION BY RATING
-- 2.1 Mean film duration for each rating
-- Rounded to 2 decimal places
-- Sorted from longest to shortest average

SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;


-- 2.2 Ratings with mean duration over 2 hours
-- 2 hours = 120 minutes

SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY mean_duration DESC;