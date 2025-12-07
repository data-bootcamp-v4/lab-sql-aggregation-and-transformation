--Shortest and longest movie durations
--Use the aggregate functions MIN() and MAX().
SELECT
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM
    film;
    --1.2 Average movie duration in hours and minutes
    SELECT
    FLOOR(AVG(length) / 60) AS avg_hours,
    ROUND(AVG(length) % 60) AS avg_minutes
FROM
    film;
    --2. Rental Date Insights
    --2.1 Calculate the number of days the company has been operating
    SELECT
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM
    rental;
    --2.2 Retrieve rental information, adding month and weekday columns (20 rows)
    SELECT
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM
    rental
LIMIT 20;
--2.3 Bonus: Add a DAY_TYPE column ('weekend' or 'workday')
SELECT
    rental_date,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM
    rental
LIMIT 20;
--3. Handling NULL Values and Formatting
--Retrieve film titles and their rental duration, replacing any potential NULL duration with 'Not Available'.
SELECT
    title AS film_title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS duration_info
FROM
    film
ORDER BY
    film_title ASC;
    
    --Bonus: Personalized Email Campaign Data
    --Retrieve concatenated first and last names and the first 3 characters of the email.
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix
FROM
    customer
ORDER BY
    last_name ASC;
    
    --Challenge 2: Film Collection Analysis
    --1.1 Total number of films released
SELECT
    COUNT(film_id) AS total_films_released
FROM
    film;
--1.2 Number of films for each rating
SELECT
    rating,
    COUNT(film_id) AS number_of_films
FROM
    film
GROUP BY
    rating;
--1.3 Number of films for each rating, sorted descending
SELECT
    rating,
    COUNT(film_id) AS number_of_films
FROM
    film
GROUP BY
    rating
ORDER BY
    number_of_films DESC;
    
    ----2.1 Mean film duration for each rating, rounded to two decimal places and sorted descending
    SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM
    film
GROUP BY
    rating
ORDER BY
    mean_duration DESC;
    ---2.2 Identify which ratings have a mean duration of over two hours (120 minutes)
SELECT
    rating,
    ROUND(AVG(length), 2) AS mean_duration
FROM
    film
GROUP BY
    rating
HAVING
    AVG(length) > 120
ORDER BY
    mean_duration DESC;
--Bonus: Non-repeated Actor Last Names
SELECT
    last_name
FROM
    actor
GROUP BY
    last_name
HAVING
    COUNT(last_name) = 1;