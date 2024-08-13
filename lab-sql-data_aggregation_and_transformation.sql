-- Challenge 1: 

-- 1. Insights on Movie Duration
SELECT * FROM sakila.film;

-- 1.1 Determine the shortest and longest movie durations:
SELECT 
-- Aggregate functions: MAX(), and MIN()
    MAX(length) AS max_duration, 
    MIN(length) AS min_duration 
FROM film;

-- 1.2. Express the average movie duration in hours and minutes:
SELECT 
	-- Arithmetic Operators: / Division to get the minutes length in hours
    FLOOR(AVG(length) / 60) AS avg_hours, 
	-- Arithmetic Operators: % or MOD Modulus (division remainder) to get the remainder minutes from previous operation 
    ROUND(AVG(length) % 60) AS avg_minutes 
FROM film;

-- 2: Insights on Rental Dates
SELECT * FROM sakila.rental;

-- 2.1. Calculate the number of days that the company has been operating:
SELECT 
	-- Formatting Dates: To display rental date as Day Month Year
	DATE_FORMAT(MAX(rental_date), '%d %M %Y') AS max_rental_date_formatted,
    DATE_FORMAT(MIN(rental_date), '%d %M %Y') AS min_rental_date_formatted,
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating 
FROM rental;

-- 2.2. Retrieve rental information with month and weekday:
SELECT 
    rental_id, 
    -- Formatting Dates: To display rental date as Day Month Year
    DATE_FORMAT(rental_date, '%d %M %Y') AS rental_date_formatted,
    EXTRACT(MONTH FROM rental_date) AS rental_month, 
    DAYNAME(rental_date) AS rental_weekday 
FROM rental 
LIMIT 20;

-- 2.3. Bonus: Add a DAY_TYPE column:
SELECT 
    rental_id, 
    DATE_FORMAT(rental_date, '%d %M %Y') AS rental_date_formatted, 
    EXTRACT(MONTH FROM rental_date) AS rental_month, 
    -- Gives the name of the day of the week for the rental date.
    DAYNAME(rental_date) AS rental_weekday, 
    CASE 
    -- Conditional Expression: CASE WHEN to specifies a condition to check
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        -- Checks if the day of the week is Sunday (1) or Saturday (7), and if so, labels it as 'weekend'.
        ELSE 'workday'
        -- Labels all other days as 'workday'.
    END AS DAY_TYPE 
FROM rental 
-- This limits the number of results returned to 20 rows.
LIMIT 20;

-- 3. Movie Collection Information
SELECT * FROM sakila.film;

-- 3.1. Retrieve film titles and rental duration, replacing NULL values:
SELECT 
    title, 
    -- If rental_duration is NULL, it will return the phrase 'Not Available'.
    -- If rental_duration is not NULL, it will return its actual value.
    IFNULL(rental_duration, 'Not Available') AS rental_duration 
FROM film 
ORDER BY rental_duration DESC;

-- 4. Bonus: Personalized Email Campaign
-- Retrieve concatenated names and first 3 characters of email:

SELECT * FROM sakila.customer;

SELECT 
	-- Concatenation Operator: || or CONCAT(): Concatenates strings together
    CONCAT(first_name, ' ', last_name) AS full_name, 
    -- Takes the first 3 characters from the email column, the result is email_prefix
    LEFT(email, 3) AS email_prefix 
FROM customer 
ORDER BY last_name ASC;


-- Challenge 2:

-- 1.  Film Insights
SELECT * FROM sakila.film;

-- 1.1 Total number of films that have been released:
SELECT COUNT(*) AS total_films_released 
-- Total Films: The COUNT(*) function counts all films.
FROM film;

-- 1.2 Number of films for each rating:
SELECT 
    rating, 
    COUNT(*) AS number_of_films 
FROM film 
-- Films by Rating: Grouping by rating and counting gives the number of films per rating.
GROUP BY rating;

-- 1.3 Number of films for each rating, sorted in descending order:
SELECT 
    rating, 
    COUNT(*) AS number_of_films 
FROM film 
GROUP BY rating 
-- Sorting by Number of Films: Grouped results by the number of films (descending) shows the most common ratings first.
ORDER BY number_of_films DESC;

-- 2. Film Duration Analysis
SELECT * FROM sakila.film;

-- 2.1. Mean film duration for each rating, sorted in descending order:
SELECT 
    rating, 
    -- Mean Duration by Rating: AVG(length) 
    -- It calculates the mean length of films, and rounding to two decimal places makes the result more readable.
    ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
ORDER BY mean_duration DESC;

-- 2.2 Identify ratings with a mean duration of over two hours:
SELECT 
    rating, 
    ROUND(AVG(length), 2) AS mean_duration 
FROM film 
GROUP BY rating 
-- Filtering by Mean Duration: The HAVING clause filters the results to only include ratings 
-- where the average length exceeds 120 minutes.
HAVING AVG(length) > 120 
ORDER BY mean_duration DESC;

-- 3. Bonus: Unique Last Names in the Actor Table
SELECT * FROM sakila.actor;

-- Determine which last names are not repeated in the actor table:
SELECT last_name 
FROM actor 
GROUP BY last_name 
-- HAVING COUNT(*) = 1 identifies last names that appear only once (not repeated) in the actor table.
HAVING COUNT(*) = 1;
