-- Challenge 1
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT
    MAX(length) AS max_duration,
    MIN(length) AS min_duration
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
SELECT
    FLOOR(AVG(length) / 60) AS hours,
    FLOOR(AVG(length) % 60) AS minutes
FROM film;

-- 2.1 Calculate the number of days that the company has been operating.
SELECT
    MIN(rental_date) AS first_rental,
    MAX(rental_date) AS last_rental,
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT
    rental_id,
    rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT
    rental_id,
    rental_date,
    CASE
        WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday')
        THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental
LIMIT 20;

-- 3.
SELECT
    title,
    IFNULL(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title;

-- 4.
SELECT
    CONCAT(first_name, ' ', last_name) AS customer_name,
    LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1.1
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3
SELECT
    rating,
    COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2.1
SELECT
    rating,
    ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

-- 2.2
SELECT
    rating,
    ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY average_duration DESC;

-- 3.
SELECT
    actor_id,
    first_name,
    last_name
FROM actor
WHERE last_name IN (
    SELECT last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(*) = 1
)
ORDER BY last_name;


