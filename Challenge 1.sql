USE sakila;

-- Shortest and longest movie durations
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

-- Average movie duration in hours and minutes

SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes
FROM film;

-- Number of days the company has been operating

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- Rental info with month and weekday, add two columns (20 rows)

SELECT rental_id,rental_date, MONTH(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Additionnal DAY_TYPE column (weekend or workday)

SELECT rental_id, rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- Film titles and rental duration (replace NULL with string 'Not Available')

SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- Concatenated names and first 3 characters of email

SELECT CONCAT(first_name, ' ', last_name) AS full_name, SUBSTRING(email, 1, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;






